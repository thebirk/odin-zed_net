package zed_net

foreign import "lib/zed_net.lib"

Address :: struct {
    host: u32,
    port: u16,
}

Socket :: struct {
    handle: i32,
    non_blocking: i32,
    ready: i32,
}

@(default_calling_convention="c", link_prefix="zed_net_")
foreign zed_net {
	get_error :: proc() -> cstring ---;
	init      :: proc() -> i32  ---;
	shutdown  :: proc()  ---;

	get_address :: proc(address: ^Address, host: cstring, port: u16) -> i32 ---;
	host_to_str :: proc(host: u32) -> cstring ---;

	socket_close       :: proc(socket: ^Socket) ---;

	udp_socket_open    :: proc(socket: ^Socket, port: u32, non_blocking: i32) -> i32 ---;
	udp_socket_send    :: proc(socket: ^Socket, destination: Address, data: rawptr, size: i32) -> i32 ---;
	udp_socket_receive :: proc(socket: ^Socket, sender: ^Address, data: rawptr, size: i32) -> i32 ---;

	tcp_socket_open       :: proc(socket: ^Socket, port: u32, non_blocking: i32, listen_socket: i32) -> i32 ---;
	tcp_connect           :: proc(socket: ^Socket, remote_addr: Address ) -> i32 ---;
	tcp_accept            :: proc(listening_socket: ^Socket, remote_socket: ^Socket, remote_addr: ^Address) -> i32 ---;
	tcp_socket_send       :: proc(remote_socket: ^Socket, data: rawptr, size: i32) -> i32 ---;
	tcp_socket_receive    :: proc(remote_socket: ^Socket, data: rawptr, size: i32) -> i32 ---;
	tcp_make_socket_ready :: proc(socket: ^Socket) -> i32 ---;
}

import "core:fmt"
main :: proc() {
	if init() != 0 {
		fmt.printf("zed_net error: '%s'\n", get_error());
		return;
	}
	defer shutdown();

	address: Address;
	get_address(&address, "localhost", 4040);
	fmt.printf("%#v\n", address);

	listen_socket: Socket;
	tcp_socket_open(&listen_socket, 4040, 0, 1);

	client_socket: Socket;
	client_addr: Address;
	for tcp_accept(&listen_socket, &client_socket, &client_addr) == 0 {
		msg := "Hello, world!\n";
		tcp_socket_send(&client_socket, &msg[0], i32(len(msg)));
		socket_close(&client_socket);
	}
}