//
//  PodongViewModel.swift
//  Podaong TY
//
//  Created by Koo on 2023/05/05.
//

import SwiftUI

class PodongViewModel: ObservableObject {
    
    // property
    // Json 파일을 가져다 SwiftUI에서 사용할 수 있도록 []안에 저장
    @Published var spotdata: [AppData] = []
//    Bundle.main.decode("spotdata.json")
    
    @Published var selectedSpot: AppData? = nil
    
    private let savedFileURL: URL
    
    
    init() {
        // 저장된 파일 URL 가져오기
        do {
            let documentDirectoryURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            savedFileURL = documentDirectoryURL.appendingPathComponent("spotdata.json")
        } catch {
            fatalError("Failed to get saved file URL: \(error)")
        }
        
        // Document 디렉토리에 파일이 존재하지 않으면 초기 파일 복사
        if !FileManager.default.fileExists(atPath: savedFileURL.path) {
            copyInitialFileToDocumentDirectory()
        }
        
        // 파일에서 데이터 불러오기
        loadSpotData()
    }
    
    func openSpotFilter(num: Int){
        self.spotdata[num].isOpened = true
        self.saveSpotData()
    }
    
    private func copyInitialFileToDocumentDirectory() {
        // Bundle에 있는 초기 파일 경로 가져오기
        guard let initialFileURL = Bundle.main.url(forResource: "spotdata", withExtension: "json") else {
            fatalError("Failed to locate initial file in the bundle.")
        }
        
        do {
            // 초기 파일을 Document 디렉토리로 복사
            try FileManager.default.copyItem(at: initialFileURL, to: savedFileURL)
        } catch {
            fatalError("Failed to copy initial file to Document directory: \(error)")
        }
    }
    
    private func loadSpotData() {
        do {
            let jsonData = try Data(contentsOf: savedFileURL)
            let decoder = JSONDecoder()
            spotdata = try decoder.decode([AppData].self, from: jsonData)
        } catch {
            // 파일에서 데이터를 불러올 수 없는 경우
            print("Failed to load spot data: \(error)")
        }
    }

    private func saveSpotData() {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(spotdata)
            try jsonData.write(to: savedFileURL)
        } catch {
            print("Failed to save spot data: \(error)")
        }
    }
    
}
