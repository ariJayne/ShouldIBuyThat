//
//  PopupDelegate.swift
//  ShouldIBuyThat
//
//  Created by Ariana on 4/22/19.
//  Copyright © 2019 Ariana. All rights reserved.
//

import Foundation

protocol PopupDelegate {
    func popupDoneSelected(value: Date)
    func popupWheneverSelected(value: String)
}
