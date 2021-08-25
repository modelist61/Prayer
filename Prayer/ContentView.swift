//
//  ContentView.swift
//  Prayer
//
//  Created by Dmitry Tokarev on 14.08.2021.
//

import SwiftUI


class ViewRouter: ObservableObject {
    @Published var currentPage: Tab = .tab1
    enum Tab {
        case tab1
        case tab2
        case tab3
    }
}

struct ContentView: View {
    
    @StateObject var viewRouter: ViewRouter
    
    var body: some View {
        ZStack {
            ZStack {
                //GradientBackground
                BackGround()
                //MainContent in ZStack
                ZStack {
                    //ScrollView in main ZSatck
                    ZStack(alignment: .bottom) {
                        switch viewRouter.currentPage {
                        case .tab1:
                            PrayerMainView()
                        case .tab2:
                            CompasMainView()
                                
                                .padding(.top, 100)
                        case .tab3:
                            PrayerKiblaView()
//                            ContainerRelativeShape()
//                                .foregroundColor(.clear)
                        }
                        
                        ZStack {
                            TabBarBackgorund()
                            //CustomTabBar Buttons
                            HStack(spacing: UIScreen.screenWidth / 7) {
                                TabBarButton(symbol: "praying",
                                             text: "Молитва")
                                    .foregroundColor(viewRouter.currentPage == .tab1 ? Color("GradientCenter2") : .black)
                                    .onTapGesture {
                                        viewRouter.currentPage = .tab1
                                    }
                                
                                TabBarButton(symbol: "kaaba",
                                             text: "Кибла")
                                    .foregroundColor(viewRouter.currentPage == .tab2 ? Color("GradientCenter2") : .black)
                                    .onTapGesture {
                                        viewRouter.currentPage = .tab2
                                    }
                                
                                TabBarButton(symbol: "lifesaver",
                                             text: "Справка")
                                    .foregroundColor(viewRouter.currentPage == .tab3 ? Color("GradientCenter2") : .black)
                                    .onTapGesture {
                                        viewRouter.currentPage = .tab3
                                    }
                            }.offset(y: 12.0)
                        }
                    }
                }.ignoresSafeArea(.all, edges: .bottom)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewRouter: ViewRouter())
    }
}

struct TabBarButton: View {
    let symbol: String
    let text: String
    //
    //    @State private var activeSymbol = true
    var body: some View {
        VStack(alignment: .center) {
            Image(symbol)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 42)
            //                .onTapGesture {
            //                    activeSymbol.toggle()
            //                }
            Text(text)
                .font(.callout)
                .fontWeight(.regular)
        }.frame(width: 70)
        
    }
}

struct BackGround: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color("GradientTop"),
                                                   Color("GradientCenter"),
                                                   Color("GradientCenter2"),
                                                   Color("GradientButtom")]),
                       startPoint: .top,
                       endPoint: .bottom)
            .ignoresSafeArea()
    }
}

extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

struct PrayerMainView: View {
    var body: some View {
        ScrollView {
            VStack {
                //VStack with header text
                VStack(alignment: .leading) {
                    //HStack location
                    HStack {
                        Text("Молитвы в ")
                            .font(.system(size: 23))
                            .fontWeight(.medium)
                        Text("Душанбе")
                            .font(.system(size: 23))
                            .fontWeight(.medium)
                            .foregroundColor(.init(white: 0.8))
                        Text(Image( systemName: "square.and.pencil"))
                            .font(.system(size: 23))
                            .fontWeight(.medium)
                    }
                    Spacer()
                    //VStack ZUHR
                    VStack(alignment: .leading, spacing: 2) {
                        HStack {
                            Text("Зухр")
                                .font(.system(size: 47))
                                .fontWeight(.bold)
                            
                            Text("12:27")
                                .font(.system(size: 47))
                                .fontWeight(.bold)
                        }
                        HStack {
                            Text("До конца Зухр осталось")
                            Text("1:05:26")
                        }
                    }
                    Spacer()
                    //Today prayer
                    HStack {
                        Text("Сегодня")
                        Text("5 мухаррама 1443г.")
                    }
                }.foregroundColor(.white)
                .frame(height: UIScreen.screenHeight / 4)
                .padding(.horizontal, 16)
            }.frame(width: UIScreen.screenWidth, alignment: .leading)
            
            PrayerGrid() //GRID
            
            ContainerRelativeShape()
                .foregroundColor(.clear)
                .padding(EdgeInsets(top: 4, leading: 16, bottom: 120, trailing: 16))
        }
    }
}

struct PrayerKiblaView: View {
    var body: some View {
        VStack {
            Image("kiblaTemp2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.screenWidth - 32)
                .rotationEffect(.init(degrees: 30))
            
            ContainerRelativeShape()
                .foregroundColor(.clear)
        }
    }
}

struct TabBarBackgorund: View {
    var body: some View {
        VStack {
            LinearGradient(gradient:
                            Gradient(colors:
                                        [Color(.white).opacity(0.0),
                                         .white]),
                           startPoint: .top,
                           endPoint: .bottom)
                .frame(height: 30)
                .offset(y: 8.0)
            Color(.white)
                .frame(height: 100)
        }
    }
}

struct PrayerGrid: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Молитва на сегодня,")
                    .font(.system(size: 23))
                    .fontWeight(.medium)
                Text("14 августа")
                    .font(.system(size: 23))
                    .fontWeight(.medium)
            }.foregroundColor(.white)
            LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 21), count: 3), spacing: 7) {
                ForEach((1..<7)) { _ in
                    PrayerSingleView(rectangleSideSize: UIScreen.screenWidth, rectangleInnerSize: UIScreen.screenWidth)
                }
            }
            HStack {
                Text("Молитва на завтра,")
                    .font(.system(size: 23))
                    .fontWeight(.medium)
                Text("15 августа")
                    .font(.system(size: 23))
                    .fontWeight(.medium)
            }.foregroundColor(.white)
            LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 21), count: 3), spacing: 7) {
                ForEach((1..<7)) { _ in
                    PrayerSingleView(rectangleSideSize: UIScreen.screenWidth, rectangleInnerSize: UIScreen.screenWidth)
                }
            }
        }
        .padding(EdgeInsets(top: 4, leading: 16, bottom: 20, trailing: 16))
    }
}
