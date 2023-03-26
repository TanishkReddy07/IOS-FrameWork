//
//  SlotMachine.swift
//
//  MAPD-724
//  ADVANCED IOS DEVELOPMENT
//
//  tanishk sai reddy peruvala = 301293616.
//  Jashandeep Kaur Sidhu-301293237.
//

import SwiftUI
import WebKit
import MapKit

struct InfoView: View {
  @Environment(\.presentationMode) var presentationMode
    @State private var showWebView = false;
    @State private var showMap = false;
    private let urlString = "https://en.wikipedia.org/wiki/Slot_machine"
  
  var body: some View {
    VStack(alignment: .center, spacing: 10) {
      LogoView()
      
      Spacer()
      
      Form {
        Section(header: Text("About the application")) {
          FormRowView(firstItem: "Application", secondItem: "Slot Machine")
          FormRowView(firstItem: "Platforms", secondItem: "iPhone, iPad, Mac")
          FormRowView(firstItem: "Copyright", secondItem: "© All rights reserved.")
          FormRowView(firstItem: "Version", secondItem: "1.0.1")
            
            
                Section(header: Text("Links to our Application")) {
                    Button(action: {
                        showMap = true
                    }, label: {
                        Text("Map")
                    })
                    .sheet(isPresented: $showMap, content: {
                        VStack() {
                            HStack() {
                              Button(action: {
                                  showMap = false
                              }, label: {
                                  Text("Close")
                              })
                            }
                            
                            
                            MapView()
                            
                        }.padding(.top, 30)
                    })
                    Button(action: {
                        showWebView = true
                    }, label: {
                        Text("Web")
                    })
                    .sheet(isPresented: $showWebView, content: {
                        VStack() {
                            HStack() {
                              Button(action: {
                                  showWebView = false
                              }, label: {
                                  Text("Close")
                              })
                            }
                            
                            WebView(url: URL(string: urlString)!)
                        }.padding(.top, 30)
                        
                    })
                }.padding(.top, 30)
        }
      }
      .font(.system(.body, design: .rounded))
      .padding(.top, 30)
    
        
    }
    .padding(.top, 40)
    .overlay(
      Button(action: {
        audioPlayer?.stop()
        self.presentationMode.wrappedValue.dismiss()
      }) {
        Image(systemName: "xmark.circle")
          .font(.title)
      }
      .padding(.top, 30)
      .padding(.trailing, 20)
      .accentColor(Color.secondary)
      , alignment: .topTrailing
      )
      .onAppear(perform: {
        playSound(sound: "background-music", type: "mp3")
      })
  }
}


// Showing the webview
struct WebView: UIViewRepresentable {
    
    var url: URL
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request);
    }
    
    
    
    func makeUIView(context: Context) -> some WKWebView {
        return WKWebView();
    }
}


// Showing the Form View
struct FormRowView: View {
  var firstItem: String
  var secondItem: String
  
  var body: some View {
    HStack {
      Text(firstItem).foregroundColor(Color.gray)
      Spacer()
      Text(secondItem)
    }
  }
}

struct InfoView_Previews: PreviewProvider {
  static var previews: some View {
    InfoView()
      .previewDevice("iPhone 12 Pro")
  }
}


// Showing the Map
struct MapView: View {
  // MARK: - PROPERTIES
  
  @State private var region: MKCoordinateRegion = {
    var mapCoordinates = CLLocationCoordinate2D(latitude: 6.600286, longitude: 16.4377599)
    var mapZoomLevel = MKCoordinateSpan(latitudeDelta: 70.0, longitudeDelta: 70.0)
    var mapRegion = MKCoordinateRegion(center: mapCoordinates, span: mapZoomLevel)
    
    return mapRegion
  }()
  
//  let locations: [NationalParkLocation] = Bundle.main.decode("locations.json")
  
  // MARK: - BODY
  
    var body: some View {
        // MARK: - No1 BASIC MAP
        Map(coordinateRegion: $region)
        
    }
  }
  


