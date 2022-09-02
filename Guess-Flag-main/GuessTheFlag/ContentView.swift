import SwiftUI



struct ContentView: View {
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    
    
    
    @State private var score = 0
    @State private var gameCount = 0
    @State private var alertAction = ""
    

    var isLastRound: Bool { gameCount == 10 }
    
    
    
    @State private var countries = ["에스토니아","스페인", "프랑스", "독일", "아일랜드", "이탈리아", "나이지리아", "폴란드", "러시아", "스페인", "영국", "미국"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var tappedFlag = ""
    
    let description = [
        "에스토니아" :  "같은 크기의 가로 줄무늬 3개가 있는 깃발. 위쪽 줄무늬 파란색, 중간 줄무늬 검은색, 아래쪽 줄무늬 흰색" ,
        "프랑스" :  "같은 크기의 세로 줄무늬 3개가 있는 깃발. 왼쪽 줄무늬 파란색, 중간 줄무늬 흰색, 오른쪽 줄무늬 빨간색" ,
        "독일" :  "같은 크기의 가로 줄무늬 3개가 있는 깃발. 위쪽 줄무늬 검정, 중간 줄무늬 빨간색, 아래쪽 줄무늬 금색" ,
        "아일랜드" :  "같은 크기의 세로 줄무늬 3개가 있는 깃발. 왼쪽 줄무늬는 녹색, 중간 줄무늬는 흰색, 오른쪽 줄무늬는 주황색" ,
        "이탈리아":  "같은 크기의 세로 줄무늬 3개가 있는 깃발. 왼쪽 줄무늬 녹색, 중간 줄무늬 흰색, 오른쪽 줄무늬 빨간색" ,
        "나이지리아" :  "같은 크기의 세로 줄무늬 3개가 있는 깃발. 왼쪽 줄무늬 녹색, 중간 줄무늬 흰색, 오른쪽 줄무늬 녹색" ,
        "폴란드" :  "같은 크기의 가로 줄무늬 2개가 있는 깃발. 위쪽 줄무늬는 흰색이고 아래쪽 줄무늬는 빨간색입니다." ,
        "러시아" :  "같은 크기의 가로 줄무늬 3개가 있는 깃발. 위쪽 줄무늬 흰색, 중간 줄무늬 파란색, 아래쪽 줄무늬 빨간색" ,
        "스페인" :  "세 개의 가로 줄무늬가 있는 깃발. 위쪽 가는 줄무늬 빨간색, 왼쪽에 문장이 있는 중간 두꺼운 줄무늬 금색, 아래쪽 가는 줄무늬 빨간색" ,
        "영국" :  "파란색 배경에 직선 및 대각선으로 겹치는 빨간색 및 흰색 십자가가 있다" ,
        "미국" :  "같은 크기의 빨간색과 흰색 줄무늬가 있는 플래그, 왼쪽 상단 모서리의 파란색 배경에 흰색 별이 있다."
    ]
    
    
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 20)
            
                .fill(
                    
                    AngularGradient(gradient: Gradient(colors: [Color.green, Color.black]),
                                    
                                    center: .topLeading,
                                    
                                    angle: .degrees(180 + 45))
                    
                )
            
                .ignoresSafeArea()
            
            
            
            
            
            VStack {
                
                Spacer()
                
                
                
                Text("Guess the Flag!")
                
                    .font(.largeTitle.bold())
                
                    .foregroundColor(.white)
                
                VStack(spacing:30) {
                    
                    VStack {
                        
                        Text("아래 국가의 국기는 무엇일까요?")
                        
                            .foregroundColor(.secondary)
    
                            .font(.subheadline.weight(.heavy))
                        
                        
                        
                        Text(countries[correctAnswer])
                        
                            .font(.largeTitle.weight(.semibold))
                        
                    }
                    
                    
                    
                    ForEach(0..<3) { number in
                        
                        Button {
                            
                            flagTapped(number)
                            
                        } label: {
                            Image(countries[number])
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(radius: 5)
                                .rotation3DEffect(.degrees(showingScore && tappedFlag == countries[number] ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                                .opacity(showingScore && tappedFlag != countries[number] ? 0.25 : 1)
                                .animation(.spring(), value: gameCount)
                                .accessibilityLabel(description[countries[number], default: "Unknown flag."])
                            
                            
                        }
                        
                        
                    }
                    
                }
                
                .frame(maxWidth: .infinity)
                
                .padding(.vertical, 20)
                
                .background(.regularMaterial)
                
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                
                
                
                Text("점수: \(score)")
                
                    .foregroundColor(.white)
                
                    .font(.title.bold())
                
                Spacer()
                
                
                
                
                
            }
            
            .padding()
            
            
            
        }
        
        .alert(scoreTitle,isPresented:  $showingScore) {
            
            Button(alertAction) {
                
                askQuestion()
                
            }
            
            
            
        } message: {
            
            Text(scoreMessage)
            
        }
        
    }
    
    func flagTapped(_ number:Int) {
        
        tappedFlag = countries[number]
        
        showingScore = true
        
        gameCount += 1
        
        
        
        if number == correctAnswer {
            
            score += 10
            
            
            scoreTitle  = isLastRound ? "게임 종료" : "정답입니다!"
            
            scoreMessage = isLastRound ? "당신의 최종 점수는 \(score) 입니다." : "당신의 점수는 \(score) 입니다."
            
        } else {
            
            scoreTitle = isLastRound ? "게임 종료" : "오답입니다!"
            
            scoreMessage = "선택하신 정답은 \(countries[number])의 국기입니다"
            
        }
        
        
        
        alertAction = isLastRound ? "게임 다시 하기" : "확인"
        
    }
    
    
    
    func askQuestion() {
        
        if isLastRound {
            
            gameCount = 0
            
            score = 0
            
        }
        
        
        
        countries = countries.shuffled()
        
        correctAnswer = Int.random(in: 0...2)
        
    }
    
    
    
}



struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ContentView()
        
    }
    
}
