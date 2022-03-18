//
//  UserView.swift
//  finder-client
//
//  Created by 이서준 on 2022/03/17.
//

import SwiftUI

struct UserView: View {
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        List(viewModel.queryRoomMate()) { roomMate in
            Text(roomMate.name)
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
