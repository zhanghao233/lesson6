package com.biz.lesson.model.student;



import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * 学生
 **/
@Entity
//@Table(name = "student")
public class Student implements Serializable {

    private static final long serialVersionUID = -9130452155839902516L;

    @GeneratedValue
    @Id
    private Integer id;

    @Column(length = 20,nullable = false)
    private String code;

    @Column(length = 20,nullable = false)
    private String name;

    @Column(length = 20,nullable = false)
    private String sex;

    private Date birthday;

    @ManyToOne(fetch = FetchType.LAZY,cascade = CascadeType.ALL)
    private Grade grade;

    @ManyToMany(fetch = FetchType.LAZY,cascade = CascadeType.ALL)
    @JoinTable(name = "student_subject",
            joinColumns = { @JoinColumn(name = "student_id", referencedColumnName = "id") },
            inverseJoinColumns = { @JoinColumn(name = "subject_id", referencedColumnName = "id") },
            uniqueConstraints = { @UniqueConstraint(columnNames = { "student_id", "subject_id" }) })
    private List<Subject> subjectList;

    public Student() {
    }

    public Student(String code, String name, String sex, Date birthday, Grade grade, List<Subject> subjectList) {
        this.code = code;
        this.name = name;
        this.sex = sex;
        this.birthday = birthday;
        this.grade = grade;
        this.subjectList = subjectList;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public Grade getGrade() {
        return grade;
    }

    public void setGrade(Grade grade) {
        this.grade = grade;
    }

    public List<Subject> getSubjectList() {
        return subjectList;
    }

    public void setSubjectList(List<Subject> subjectList) {
        this.subjectList = subjectList;
    }

    @Override
    public String toString() {
        return "Student{" +
                "id=" + id +
                ", code='" + code + '\'' +
                ", name='" + name + '\'' +
                ", sex='" + sex + '\'' +
                ", birthday=" + birthday +
                ", grade=" + grade +
                ", subjectList=" + subjectList +
                '}';
    }
}
