import Foundation

//MARK: - Model
struct Student {
    var name : String?
    var scores : [Score]?
}

struct Score {
    var name : String?
    var score : String?
}

//MARK: - Storage (ViewModel)
class Storage {
    var studentDatas : [Student] = []
    
    /// 학생 추가
    func add(name : String) {
        
    }
    /// 성적 추가
    func add(name : String, score : String) {
        
    }
    
    /// 학생 삭제
    func del(name: String){
        
    }
    
    /// 성적 삭제
    func del(student: String, name: String){
        
    }
    
    func isExistStudent(name : String) -> Bool {
        
        return false
    }
    
    
}




//MARK: - View
class CreditManager {
    let storage = Storage()
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
        
    }
    
    /// 학생 삭제
    func delStudent() {
        
    }
    
    /// 성적 추가
    func addScore() {
        
        
    }
    
    /// 성적 삭제
    func delScore() {
        
        
    }
    
    /// 평점 보기
    func viewScore() {
        
        
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


