//
//  NetworkService.swift
//  shenji-ios
//
//  Created by Kevin Peng on 2020-08-02.
//

import Foundation
import Starscream

final class NetworkService {
    static let shared = NetworkService()
    private let socket: WebSocket
    var isConnected = false

    private init() {
        guard let url = URL(string: "http://127.0.0.1:8080/echo") else {
            fatalError("Invalid URL")
        }
        var request = URLRequest(url: url)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
    }

    private func handleDidConnect() {
        print("WebSocket connected!")
    }

    private func handleDidReceiveText(string: String) {
        print("Received text: \(string)")
    }
}

extension NetworkService: WebSocketDelegate {
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(_):
            isConnected = true
            handleDidConnect()
        case .disconnected(let reason, let code):
            isConnected = false
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            handleDidReceiveText(string: string)
        case .binary(let data):
            print("Received data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            isConnected = false
        case .error(let error):
            isConnected = false
            handleError(error)
        }
    }

    private func handleError(_ error: Error?) {
        print(error?.localizedDescription ?? "Unknown Error")
    }


}
