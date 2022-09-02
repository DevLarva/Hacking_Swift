import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        // calculate the total per person here
        let peopleCount = Double(numberOfPeople + 2 )
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("금액", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("사람 수를 입력해주세요.",selection: $numberOfPeople){
                        ForEach(2..<100) {
                            Text("\($0) 명")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage",selection: $tipPercentage) {
                        ForEach(tipPercentages, id:\.self) {
                            Text($0,format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                        Text("얼마나 많은 팁을 제공하시겠습니까?")
                    }


                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD?"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

