//
//  CarContentView.swift
//  SwiftUITutorial
//
//  Created by 이동근 on 2021/07/05.
//

import SwiftUI

struct CarContentView: View {
    @ObservedObject var carStore: CarStore = CarStore(cars: carData)
    
    var body: some View {
        NavigationView {
            List {
                ForEach(carStore.cars) { car in
                    
                    ListCell(car: car)
                }
                .onDelete(perform: deleteItems)
                .onMove(perform: moveItems)
            }
            .navigationBarTitle(Text("EV Cars"))
            .navigationBarItems(leading: NavigationLink(
                                    destination: AddNewCar(carStore: carStore),
                                    label: {
                                        Text("Add")
                                            .foregroundColor(.blue)
                                    }), trailing: EditButton())
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        carStore.cars.remove(atOffsets: offsets)
    }
    
    func moveItems(from source: IndexSet, to destination: Int) {
        carStore.cars.move(fromOffsets: source, toOffset: destination)
    }
}

struct CarContentView_Previews: PreviewProvider {
    static var previews: some View {
        CarContentView()
    }
}

struct ListCell: View {
    var car: Car
    
    var body: some View {
        NavigationLink(destination: CarDetailView(selectedCar: car)) {
            HStack {
                Image(car.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 60)
                
                Text(car.name)
            }
        }
    }
}
