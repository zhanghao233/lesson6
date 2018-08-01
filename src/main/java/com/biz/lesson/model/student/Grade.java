package com.biz.lesson.model.student;


import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

/**
 *
 **/
@Entity
@Table(name="grade")
public class Grade implements Serializable {

    private static final long serialVersionUID = 9150890481463675986L;

    @Id
    @GeneratedValue
    @Column(length = 25,nullable = false)
    private Integer gradeId;

    @Column(length = 20,nullable = false)
    private String gradeName;

    @OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL, mappedBy = "grade")
    private List<Student> studentList;

    public Grade() {
    }

    public Grade(String gradeName) {
        this.gradeName = gradeName;
    }

    public Grade(String gradeName, List<Student> studentList) {
        this.gradeName = gradeName;
        this.studentList = studentList;
    }

    public Integer getGradeId() {
        return gradeId;
    }

    public void setGradeId(Integer gradeId) {
        this.gradeId = gradeId;
    }

    public String getGradeName() {
        return gradeName;
    }

    public void setGradeName(String gradeName) {
        this.gradeName = gradeName;
    }

    public List<Student> getStudentList() {
        return studentList;
    }

    public void setStudentList(List<Student> studentList) {
        this.studentList = studentList;
    }

    @Override
    public String toString() {
        return "Grade{" +
                "gradeId=" + gradeId +
                ", gradeName='" + gradeName + '\'' +
                '}';
    }
}
