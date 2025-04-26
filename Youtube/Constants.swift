//
//  Constants.swift
//  Youtube
//
//  Created by Hậu Nguyễn on 26/4/25.
//

import Foundation

struct Constants {
    static var API_KEY = "AIzaSyCE9K_2hedSDfkPGR6132GywEq8QE5XKF8"
    static var PLAY_LIST_KEY = "PLMRqhzcHGw1Yw2XJyHnxoEXPBCdMaRzkf"
    static var URL_API = "https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(PLAY_LIST_KEY)&key=\(API_KEY)"
}
