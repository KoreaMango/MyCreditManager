import Foundation

//MARK: - Model
struct Student {
    var name : String?
    var subjects : [Subject]?
}

struct Subject {
    var name : String
    var score : String
}

//MARK: - ViewModel
class ViewModel {
    var studentDatas : [Student] = []
    
    /// 학생 추가
    func add(student : String) {
        
    }
    /// 성적 추가
    func add(student : String, subject: String , score : String) {
        
    }
    
    /// 학생 삭제
    func del(student: String){
        
    }
    
    /// 성적 삭제
    func del(student: String, subject: String){
        
    }
    
    
    
    //MARK: - 로직
    func isAddScoreInput(input : [String]) -> Bool {
        
        return true
    }
    func isDelScoreInput(input : [String]) -> Bool {
        
        return true
    }
    
    func isExistStudent(student : String) -> Bool {
        
        return false
    }
    func isExistScore(name: String) -> Bool {
        
        return false
    }
    func findStudent(student: String) -> Student {
        
        return Student()
    }
    func average(subjects : [Subject] ) -> Double {
        
        return 1
    }
}




//MARK: - View
class CreditManager {
    let viewModel = ViewModel()
    var state : Bool = true
    
    func start() {
        while state {
            print("원하는 기능을 입력해주세요.")
            print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
            
            let input = readLine()?.uppercased()
            
            switch input {
            case "1":
                addStudent()
                break
            case "2":
                delStudent()
                break
            case "3":
                addScore()
                break
            case "4":
                delScore()
                break
            case "5":
                viewScore()
                break
            case "X":
                close()
                break
            default:
                print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
                break
            }
        }
    }
    
    /// 학생 추가
    func addStudent() {
        print("추가할 학생의 이름을 입력해주세요.")
        let name = readLine()?.trimmingCharacters(in: .whitespaces)
        if let name = name {
            if name.isEmpty {
                print("입력이 잘못되었습니다. 다시 확인해주세요.")
            }
            else {
                if viewModel.isExistStudent(student: name) {
                    print("\(name)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
                }
                else {
                    viewModel.add(student: name)
                    print("\(name) 학생을 추가했습니다.")
                }
            }
        }
        else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        }
    }
    
    /// 학생 삭제
    func delStudent() {
        print("삭제할 학생의 이름을 입력해주세요.")
        let name = readLine()?.trimmingCharacters(in: .whitespaces)
        if let name = name {
            if name.isEmpty {
                print("입력이 잘못되었습니다. 다시 확인해주세요.")
            }
            else {
                if viewModel.isExistStudent(student: name) {
                    viewModel.del(student: name)
                }
                else {
                    print("\(name) 학생을 찾지 못했습니다.")
                }
            }
        }
        else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        }
    }
    
    /// 성적 추가
    func addScore() {
        print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.")
        print("입력예) Mickey Swift A+")
        print("만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
        let input : [String]? = readLine()?.split(separator: " ").map{String($0)}
        
        if let input = input {
            if viewModel.isAddScoreInput(input: input) {
                viewModel.add(student: input[0], subject: input[1] ,score: input[2])
                print("\(input[0]) 학생의 \(input[1]) 과목이 \(input[2])로 추가(변경)되었습니다.")
            }else {
                print("입력이 잘못되었습니다. 다시 확인해주세요.")
            }
        }
        else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        }

    }
    
    /// 성적 삭제
    func delScore() {
        print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
        print("입력예) Mickey Swift")
        let input : [String]? = readLine()?.split(separator: " ").map{String($0)}
        if let input = input {
            if viewModel.isDelScoreInput(input: input) {
                if viewModel.isExistStudent(student: input[0]){
                    if viewModel.isExistScore(name: input[1]){
                        viewModel.del(student: input[0], subject: input[1])
                    }
                    else {
                        print("\(input) 과목을 찾지 못했습니다.")
                    }
                }
                else {
                    print("\(input[0]) 학생을 찾지 못했습니다.")
                }
            }
            else {
                print("입력이 잘못되었습니다. 다시 확인해주세요.")
            }
        }
        else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        }
    }
    
    /// 평점 보기
    func viewScore() {
        print("평점을 알고싶은 학생의 이름을 입력해주세요.")
        let name = readLine()
        if let name = name {
            if viewModel.isExistStudent(student: name){
                let student = viewModel.findStudent(student: name)
                if let subjects = student.subjects {
                    for subject in subjects {
                        print("\(subject.name): \(subject.score)")
                    }
                    print("평점 : \(viewModel.average(subjects: subjects))")
                }
                else {
                    print("성적이 없습니다.")
                }
            }
            else {
                print("\(name) 학생을 찾지 못했습니다.")
            }
        } else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        }
    }
    
    /// 실행 종료
    func close() {
        state = false
        print("프로그램을 종료합니다...")
    }
}


//MARK: - 호출
let manager = CreditManager()

manager.start()


