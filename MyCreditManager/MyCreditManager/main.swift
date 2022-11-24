//
//  main.swift
//  MyCreditManager
//
//  Created by TIKE on 2022/11/23.
//

import Foundation


var studentArr : [Student] = []

var input = "O"

repeat {
    
    print("원하는 기능을 입력해주세요. \n1: 학생추가, 2: 학생 삭제, 3: 성적 추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
    if let line = readLine() {
        
        input = line
        
        switch line {
            case "1":
                addStudent()
            case "2":
                delStudent()
            case "3":
                addScoreToStudent()
            case "4":
                delScore()
            case "5":
                calculGrade()
            case "X":
                print("프로그램 종료...")
            default:
                print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 또는 X를 입력해주세요.")
        }
        
    }
    
} while input != "X"


func addStudent() {
    
    print("추가할 학생의 이름을 입력해 주세요.")
    
    if let line = readLine() {
        
        let contain = studentArr.contains {
            i in i.name == line
        }
        
        if (line.count < 1)  {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        } else if (contain) {
            print(line + "학생은 이미 존재하는 학생입니다. 추가하지 않습니다.")
        } else {
            let newStudent = Student(name: line, scoreStat: [])
            studentArr.append(newStudent)
            print(line + "학생을 추가했습니다.")
        }
        
        
//        if (line.count < 1)  {
//            print("입력이 잘못되었습니다. 다시 확인해주세요.")
//        } else if (studentArr.contains(line)) {
//            print(line + "학생은 이미 존재하는 학생입니다. 추가하지 않습니다.")
//        } else {
//            studentArr.append(line)
//            print(line + "학생을 추가했습니다.")
//        }
        
    }
    
}


func delStudent() {
    
    print("삭제할 학생의 이름을 입력해 주세요.")
    
    if let line = readLine() {
        
        let contain = studentArr.firstIndex {
            i in i.name == line
        }
        
        if (line.count < 1)  {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        } else if let num = contain {
            studentArr.remove(at: num)
            print(line + "학생을 삭제하였습니다.")
        } else {
            print(line + "학생을 찾지 못했습니다.")
        }
        
//        if (line.count < 1)  {
//            print("입력이 잘못되었습니다. 다시 확인해주세요.")
//        } else if (!studentArr.contains($0.line)) {
//            print(line + "학생을 찾지 못했습니다.")
//        } else {
//            studentArr = studentArr.filter { $0 != line }
//            print(line + "학생을 삭제하였습니다.")
//        }
    }
    
}


func addScoreToStudent() {
    
    print("성적을 추가할 학생의 이름, 과목, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.\n 입력예) Mickey Swift A+ \n 만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
    
    if let line = readLine() {
        
        let inputArr = line.split(separator: " ")
        
        let containIdx = studentArr.firstIndex {
            i in i.name == String(inputArr[0])
        }
        
        if (line.count < 1 || inputArr.count < 3 || convertScore(String(inputArr[2])) == -1)  {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        } else if let num = containIdx {
            
            let scoreIdx = studentArr[num].scoreStat.firstIndex {
                i in i.subject == String(inputArr[1])
            }
            
            if let hasScore = scoreIdx {
                studentArr[num].scoreStat[hasScore].scoreLevel = String(inputArr[2])
            } else {
                studentArr[num].scoreStat.append(Score(subject: String(inputArr[1]), scoreLevel: String(inputArr[2])))
            }
            
            print("\(String(inputArr[0])) 학생의 \(String(inputArr[1])) 과목이 \(String(inputArr[2]))로 추가(변경)되었습니다.")
        } else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        }
    }
}



func delScore() {
    
    print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.\n 입력예) Mickey Swift")
    
    if let line = readLine() {
        
        let inputArr = line.split(separator: " ")
        
        let containIdx = studentArr.firstIndex {
            i in i.name == String(inputArr[0])
        }
        
        if (line.count < 1 || inputArr.count < 2)  {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        } else if let num = containIdx {
            
            let scoreIdx = studentArr[num].scoreStat.firstIndex {
                i in i.subject == String(inputArr[1])
            }
            
            if let num = scoreIdx {
                studentArr[num].scoreStat.remove(at: num)
                print("\(String(inputArr[0])) 학생의 \(String(inputArr[1])) 과목이 삭제되었습니다.")
            }else {
                print("\(String(inputArr[0])) 학생은 해당 성적이 없습니다.")
            }
            
        } else {
            print("\(String(inputArr[0]))학생을 찾지 못했습니다.")
        }
    }
}


func calculGrade() {
    
    
    print("평점을 알고 싶은 학생의 이름을 입력해주세요")
    
    if let line = readLine() {
        
        let contain = studentArr.firstIndex {
            i in i.name == line
        }
        
        if (line.count < 1)  {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        } else if let num = contain {
            
            var sum = 0.0
            
            for i in studentArr[num].scoreStat {
                print("\(i.subject): \(i.scoreLevel)")
                sum += convertScore(i.scoreLevel)
            }
            
            print("평점:\(String(format: "%.2f", sum/Double(studentArr[num].scoreStat.count)))")
            
        } else {
            print(line + "학생을 찾지 못했습니다.")
        }
        
    }
}


func convertScore(_ i: String) -> Double{
    
    switch i {
        case "A+":
            return 4.5
        case "A":
            return 4
        case "B+":
            return 3.5
        case "B":
            return 3
        case "C+":
            return 2.5
        case "C":
            return 2
        case "D+":
            return 1.5
        case "D":
            return 1
        case "F":
            return 0
        default:
            return -1
    }
    
   
}


