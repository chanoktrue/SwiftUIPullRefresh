//
//  ContentView.swift
//  SwiftUIPullRefresh
//
//  Created by Thongchai Subsaidee on 31/5/2564 BE.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var productVM = ProductViewModel()

    var body: some View {
        ListFromServer(productVM: productVM)
//        ListFromLocal()
    }
 
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct ListFromLocal: View {
    @State var datas = ["Test 1", "Test 2", "Test 3", "Test 4", "Test 5", "Test 6", "Test 7", "Test 8"]
    @State var refresh = Refresh(started: false, released: false)
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                GeometryReader { g -> AnyView in
                    
                    print(g.frame(in: .global).minY)
                    
                    DispatchQueue.main.async {
                        if refresh.startOffSet == 0 {
                            refresh.startOffSet = g.frame(in: .global).minY
                        }
                        
                        refresh.offSet = g.frame(in: .global).minY
                        
                        if refresh.offSet - refresh.startOffSet > 50 && !refresh.started {
                            refresh.started = true
                        }
                        
                        // checking if refresh in started and drag is released ...
                        
                        if refresh.startOffSet == refresh.offSet && refresh.started && !refresh.released {
                            refresh.released = true
                            updateData()
                        }
                    }
                    
                   return AnyView(Color.black.frame(width: 0, height: 0))
                }
                .frame(width: 0, height: 0)
                
                ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                    

                    HStack {
                        
                        if refresh.started && refresh.released {
                            ProgressView()
                                .animation(.easeIn)
                        }else {
                            Image(systemName: "arrow.down")
                                .font(.system(size: 16, weight: .heavy))
                                .foregroundColor(.gray)
                                .rotationEffect(.degrees(refresh.started ? 180 : 0))
                                .animation(.easeIn)
                                .opacity(refresh.started ? 1 : 0)
                        }
                    }

                    
                    ScrollView {
                        ForEach(datas, id: \.self) { data in
                            HStack {
                                Text(data)
                                Spacer()
                                Image(systemName: "arrow.right.circle.fill")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                        }
                    }
                    .offset(y: refresh.released ? 30 : 0)
                }
            }
            .navigationBarTitle(Text("Pull Refresh"), displayMode: .inline)
        }
    }
    
    func updateData() {
        print("update data...")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation(.easeIn) {
                refresh.started = false
                refresh.released = false
                datas.append("Update....")
            }
        }
    }
}

struct Refresh {
    var startOffSet: CGFloat = 0
    var offSet: CGFloat = 0
    var started: Bool
    var released: Bool
}


struct ListFromServer: View {
    
    @ObservedObject var productVM =  ProductViewModel()
    @State var refresh = Refresh(started: false, released: false)
    
    var body: some View {
        NavigationView {
      
                ScrollView {
                    
                    GeometryReader {geo -> AnyView in
                        DispatchQueue.main.async {
                            
                            if refresh.startOffSet == 0 {
                                refresh.startOffSet = geo.frame(in: .global).minY
                            }
                            refresh.offSet = geo.frame(in: .global).minY
                            
                            if refresh.offSet - refresh.startOffSet > 50 && !refresh.started {
                                refresh.started = true
                            }
                            
                            if refresh.startOffSet == refresh.offSet && refresh.started && !refresh.released {
                                withAnimation(.easeIn) {
                                    refresh.released = true
                                    updateData()
                                }
                            }
                        }
                        return AnyView(Color.blue.frame(width: 0, height: 0))
                    }
                    .frame(width: 0, height: 0)
                    
                    // loading..
                    VStack {
                        if refresh.started && refresh.released {
                            ProgressView()
                                .padding()
                        }else {
                            Image(systemName: "arrow.down")
                                .font(.system(size: 16, weight: .heavy))
                                .foregroundColor(.gray)
                                .rotationEffect(.degrees(refresh.started ? 180 : 0))
                                .animation(.easeIn)
                                .opacity(refresh.started ? 1 : 0)
                        }
                    }
                    
                    ForEach(productVM.products, id:\.self) { product in
                        FoodCell(product: product)
                    }
                }

            
            .onAppear{
                updateData()
            }
            .navigationBarTitle(Text("Foods"), displayMode: .inline)
        }
        
    }
    
    func updateData() {
        print("updating...")
        
        productVM.getData {
            if $0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.easeIn) {
                        refresh.started = false
                        refresh.released = false
                    }
                }
            }
        }
    
    }
}


struct FoodCell: View {
    
    var product: ProductModel
    
    var body: some View {
        VStack {
            
            AsyncImageView(url: URL(string: product.post_image)!)
                .aspectRatio(contentMode: .fit)
            
            Text(product.post_name)
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
    }
    
}
