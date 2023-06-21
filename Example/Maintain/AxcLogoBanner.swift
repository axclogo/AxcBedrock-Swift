//
//  AxcLogoBanner.swift
//  Renewal
//
//  Created by 赵新 on 2023/2/22.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation

enum AxcLogoBanner: String {
    case larry3D, lean, linux, orge

    var banner: String {
        switch self {
        case .larry3D:
            return " ______                   __\n/\\  _  \\                 /\\ \\\n\\ \\ \\L\\ \\   __  _    ___ \\ \\ \\        ___      __      ___\n \\ \\  __ \\ /\\ \\/'\\  /'___\\\\ \\ \\  __  / __`\\  /'_ `\\   / __`\\\n  \\ \\ \\/\\ \\\\/>  </ /\\ \\__/ \\ \\ \\L\\ \\/\\ \\L\\ \\/\\ \\L\\ \\ /\\ \\L\\ \\\n   \\ \\_\\ \\_\\/\\_/\\_\\\\ \\____\\ \\ \\____/\\ \\____/\\ \\____ \\\\ \\____/\n    \\/_/\\/_/\\//\\/_/ \\/____/  \\/___/  \\/___/  \\/___L\\ \\\\/___/\n                                               /\\____/\n                                               \\_/__/\n"
        case .lean:
            return "    _/_/                        _/\n _/    _/  _/    _/    _/_/_/  _/          _/_/      _/_/_/    _/_/\n_/_/_/_/    _/_/    _/        _/        _/    _/  _/    _/  _/    _/\n_/    _/  _/    _/  _/        _/        _/    _/  _/    _/  _/    _/\n_/    _/  _/    _/    _/_/_/  _/_/_/_/    _/_/      _/_/_/    _/_/\n                                                     _/\n                                                _/_/"
        case .linux:
            return "    AAA                 LL\n   AAAAA  xx  xx   cccc LL       oooo   gggggg  oooo\n  AA   AA   xx   cc     LL      oo  oo gg   gg oo  oo\n  AAAAAAA   xx   cc     LL      oo  oo ggggggg oo  oo\n  AA   AA xx  xx  ccccc LLLLLLL  oooo       gg  oooo\n                                        ggggg"
        case .orge:
            return "            _                 __\n           /_\\  __  __ ___   / /   ___    __ _   ___\n          //_\\\\ \\ \\/ // __| / /   / _ \\  / _` | / _ \\\n         /  _  \\ >  <| (__ / /___| (_) || (_| || (_) |\n         \\_/ \\_//_/\\_\\\\___|\\____/ \\___/  \\__, | \\___/\n                                         |___/        "
        }
    }
}
