import Foundation

//MARK: - Model
struct Student {
    var name : String
    var subjects : [Subject]
}

struct Subject {
    var name : String
    var score : String
}

//MARK: - ViewModel
class ViewModel {
    private var studentDatas : [Student] = []
    
    func show() {
        print(studentDatas)
    }
    
    /// 학생 추가
    func add(studentName : String) {
        let studentData = Student(name: studentName, subjects: [])
        studentDatas.append(studentData)
    }
    
    /// 성적 추가
    func add(studentName : String, subjectName: String , score : String) {
        var idx = getStudentIdx(studentName: studentName)
        let subjectData = Subject(name: subjectName, score: score)
        studentDatas[idx].subjects.append(subjectData)

    }
    
    /// 학생 삭제
    func del(studentName: String){
        var idx = getStudentIdx(studentName: studentName)
        
        studentDatas.remove(at: idx)
    }
    
    /// 성적 삭제
    func del(studentName: String, subjectName: String){
        var studentIdx = getStudentIdx(studentName: studentName)
        var subjectIdx = getSubjectIdx(studentName: studentName, subjectName: subjectName, studentIdx: studentIdx)
        
        studentDatas[studentIdx].subjects.remove(at: subjectIdx)
    }
    
    
    
    //MARK: - 로직
    func isAddScoreInput(input : [String]) -> Bool {
        if input.count == 3 {
            if isExistStudent(studentName: input[0]){
                // 여기에 추가 조건 등록
                return true
            }
        }
        return false
        
    }
    
    func isDelScoreInput(input : [String]) -> Bool {
        if input.count == 2 {
            return true
        }
        return false
    }
    
    func isExistStudent(studentName : String) -> Bool {
       return findStudent(studentName: studentName) != nil
    }
    
    func isExistScore(studentName: String, subjectName: String) -> Bool {
        if let student = findStudent(studentName: studentName) {
            let subjects = student.subjects
            for subject in subjects {
                if subjectName == subject.name {
                    return true
                }
            }
        }
        return false
    }
    
    func findStudent(studentName: String) -> Student? {
        for studentData in studentDatas {
            if studentData.name == studentName {
                return studentData
            }
        }
        return nil
    }
    
    func average(subjects : [Subject] ) -> Double {
        let sum = subjects
            .map{ subject in
                if subject.score == "A+" {
                    return 4.5
                } else if subject.score == "A" {
                    return 4.0
                } else if subject.score == "B+" {
                    return 3.5
                } else if subject.score == "B" {
                    return 3.0
                } else if subject.score == "C+" {
                    return 2.5
                } else if subject.score == "C" {
                    return 2.0
                } else if subject.score == "D+" {
                    return 1.5
                } else if subject.score == "D" {
                    return 1.0
                } else {
                    return 0
                }
            }
            .reduce(0.0) {$0 + $1}
        
        let result : Double = Double(sum) / Double(subjects.count)
        
        return result
    }
    
    func getStudentIdx(studentName: String) -> Int {
        var idx = -1
        
        for (index,studentData) in studentDatas.enumerated() {
            if studentData.name == studentName {
               idx = index
            }
        }
        
        return idx
    }
    
    func getSubjectIdx(studentName : String, subjectName : String, studentIdx: Int) -> Int {
        var idx = studentIdx
        var subjectIdx = 0
        
        let subjects = studentDatas[idx].subjects
        
        for (index,subject) in subjects.enumerated() {
            if subject.name == subjectName {
                subjectIdx = index
            }
        }
        
        return subjectIdx
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
                viewModel.show()
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
                if viewModel.isExistStudent(studentName: name) {
                    print("\(name)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
                }
                else {
                    viewModel.add(studentName: name)
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
                if viewModel.isExistStudent(studentName: name) {
                    viewModel.del(studentName: name)
                    print("\(name) 학생을 삭제했습니다.")
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
                viewModel.add(studentName: input[0], subjectName: input[1] ,score: input[2])
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
                if viewModel.isExistStudent(studentName: input[0]){
                    if viewModel.isExistScore(studentName: input[0],subjectName: input[1]){
                        viewModel.del(studentName: input[0], subjectName: input[1])
                        print("\(input[0]) 학생의 \(input[1]) 과목의 성적이 삭제되었습니다.")
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
            if viewModel.isExistStudent(studentName: name){
                let student = viewModel.findStudent(studentName: name)
                let subjects = student?.subjects ?? []
                for subject in subjects {
                    print("\(subject.name): \(subject.score)")
                }
                print("평점 : \(viewModel.average(subjects: subjects))")
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


