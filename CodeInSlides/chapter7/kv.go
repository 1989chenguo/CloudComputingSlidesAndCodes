package main

import (
	"fmt"
	"log"
	"net"
	"net/rpc"
	"sync"
	"flag"
	// "os"
)

//
// Common RPC request/reply definitions
//

const (
	OK       = "OK"
	ErrNoKey = "ErrNoKey"
)

type Err string

type PutArgs struct {
	Key   string
	Value string
}

type PutReply struct {
	Err Err
}

type GetArgs struct {
	Key string
}

type GetReply struct {
	Err   Err
	Value string
}

type DeleteArgs struct {
	Key string
}

type DeleteReply struct {
	Err   Err
}

type ShowArgs struct {
	Type int
}

type ShowReply struct {
	Data map[string]string
}

//
// Client
//

func connect(addr string) *rpc.Client {
	client, err := rpc.Dial("tcp", addr)
	if err != nil {
		log.Fatal("dialing:", err)
	}
	return client
}

func get(client *rpc.Client, key string) string {
	args := GetArgs{key}
	reply := GetReply{}
	err := client.Call("KV.Get", &args, &reply)
	if err != nil {
		log.Fatal("error:", err)
	}
	return reply.Value
}

func put(client *rpc.Client, key string, val string) {
	args := PutArgs{key, val}
	reply := PutReply{}
	err := client.Call("KV.Put", &args, &reply)
	if err != nil {
		log.Fatal("error:", err)
	}
}

func deleteKey(client *rpc.Client, key string) {
	args := DeleteArgs{key}
	reply := DeleteReply{}
	err := client.Call("KV.Delete", &args, &reply)
	if err != nil {
		log.Fatal("error:", err)
	}
}

func showAll(client *rpc.Client) map[string]string {
	args := ShowArgs{}
	reply := ShowReply{}
	err := client.Call("KV.Show", &args, &reply)
	if err != nil {
		log.Fatal("error:", err)
	}
	return reply.Data
}

func notifyExit(client *rpc.Client) {
	args := ""
	reply := "false"
	err := client.Call("KV.Exit", &args, &reply)
	if reply!="true" {
		fmt.Println("Server does not exit successfully! reply: ", reply)
	}
	if err != nil {
		log.Fatal("error:", err)
	}
}

func client(addr string) {
	client := connect(addr)
	var inOP, inKey, inValue string
    for {
    	fmt.Printf("Input a KV operation (operation [key] [value]):\t")
    	fmt.Scanln(&inOP, &inKey, &inValue)
    	// fmt.Println(inOP, inKey, inValue)
    	if inOP=="put" {
    		put(client, inKey, inValue)
    		fmt.Printf("put(%s, %s)\n", inKey, inValue)
    	} else if inOP=="get" {
    		value:=get(client, inKey)
    		fmt.Printf("get(%s) -> %s\n", inKey, value)
    	} else if inOP=="delete" {
    		deleteKey(client, inKey)
    		fmt.Printf("delete(%s)\n", inKey)
		} else if inOP=="show" {
			kvData:=showAll(client)
			fmt.Println("show KV: ", kvData)
    	} else if inOP=="exit" {
    		notifyExit(client);
    		break
    	} else {
    		fmt.Println("Unknown operation ", inOP, inKey, inValue)
    	}
    }
    client.Close()
}

//
// Server
//

type KV struct {
	mu   sync.Mutex
	data map[string]string
}

func server(addr string) {
	kv := new(KV)
	kv.data = map[string]string{}
	rpcs := rpc.NewServer()
	rpcs.Register(kv)
	l, e := net.Listen("tcp", addr)
	if e != nil {
		log.Fatal("listen error:", e)
	}
	for {
		conn, err := l.Accept()
		if err == nil {
			go rpcs.ServeConn(conn)
		} else {
			break
		}
	}
	l.Close()
}

func (kv *KV) Get(args *GetArgs, reply *GetReply) error {
	kv.mu.Lock()
	fmt.Printf("get(%s)\n", args.Key)
	defer kv.mu.Unlock()

	val, ok := kv.data[args.Key]
	if ok {
		reply.Err = OK
		reply.Value = val
	} else {
		reply.Err = ErrNoKey
		reply.Value = ""
	}
	return nil
}

func (kv *KV) Put(args *PutArgs, reply *PutReply) error {
	kv.mu.Lock()
	fmt.Printf("put(%s, %s)\n", args.Key, args.Value)
	defer kv.mu.Unlock()

	kv.data[args.Key] = args.Value
	reply.Err = OK
	return nil
}

func (kv *KV) Delete(args *DeleteArgs, reply *DeleteReply) error {
	kv.mu.Lock()
	fmt.Printf("delete(%s)\n", args.Key)
	defer kv.mu.Unlock()

	delete(kv.data, args.Key)
	reply.Err = OK
	return nil
}

func (kv *KV) Show(args *ShowArgs, reply *ShowReply) error {
	kv.mu.Lock()
	fmt.Println("show")
	defer kv.mu.Unlock()

	reply.Data = kv.data
	return nil
}

func (kv *KV) Exit(args *string, reply *string) error {
	kv.mu.Lock()
	fmt.Println("exit")
	defer kv.mu.Unlock()
	// defer os.Exit(0);

	*reply = "true"
	return nil
}

//
// main
//

func main() {
	var mode string 
	flag.StringVar(&mode, "mode", "", "client or server")
   	var addr string 
   	flag.StringVar(&addr, "addr", "", "IP address and port (IP:port)")
    flag.Parse()

	if mode=="server" {
		fmt.Println("Listen to ", addr)
	} else if mode=="client"  {
		fmt.Println("Connect to ", addr)
	} else {
		flag.Usage()
		return
	}
	fmt.Println("Working as ", mode)
	fmt.Printf("This is a simple KV store. Please play with fun ... \n\n")
	
	if mode=="server" {
		server(addr)
	} else if mode=="client"  {
		client(addr)
	}
    
    fmt.Println("exit ...")
}
