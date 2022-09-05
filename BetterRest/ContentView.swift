//
//  ContentView.swift
//  BetterRest
//
//  Created by 백대홍 on 2022/09/05.
//
import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var aleatTitle = ""
    @State private var aleatMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .leading, spacing: 0) {
                Text("몇시에 기상하고 싶으신가요?")
                    .font(.headline)

                DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                }
                
                    VStack(alignment: .leading, spacing: 0) {
                        Text("원하는 수면시간을 선택해주세요.")
                            .font(.headline)
                        
                        Stepper("\(sleepAmount.formatted())시간", value: $sleepAmount, in: 4...12, step: 0.25)
                    }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("카페인 섭취량")
                        .font(.headline)
                    
                    Stepper(coffeeAmount == 1 ? "1 컵" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
                }
            }
            .navigationTitle("BetterRest")
            .toolbar {
                Button("Caculate",action: caculateBedtime)
            }
            .alert(aleatTitle,isPresented: $showingAlert) {
                Button("확인") { }
            } message: {
                Text(aleatMessage)
            }
        }
    }
    func caculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double((coffeeAmount)))
            
            let sleepTime = wakeUp - prediction.actualSleep
            aleatTitle = "당신의 가장 이상적인 취침 시간은"
            aleatMessage = sleepTime.formatted(date:.omitted,time: .shortened)
        } catch {
            aleatTitle = "오류"
            aleatMessage = "죄송합니다.문제가 발생 하였습니다."
        }
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
