package com.biz.lesson.model.student;


import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

/**
 *
 **/
@Entity
@Table(name = "subject")
public class Subject implements Serializable {

    private static final long serialVersionUID = -3531993133823886897L;

    @Id
    @GeneratedValue
    private Integer id;

    @Column(length = 20,nullable = false)
    private String name;

    @ManyToMany(fetch = FetchType.LAZY,cascade = CascadeType.ALL)
    @JoinTable(name = "student_subject",
            joinColumns = { @JoinColumn(name = "subject_id", referencedColumnName = "id") },
            inverseJoinColumns = { @JoinColumn(name = "student_id", referencedColumnName = "id") },
            uniqueConstraints = { @UniqueConstraint(columnNames = { "subject_id", "student_id" }) })
    private List<Student> studentList;

    public Subject() {
    }

    public Subject(String name) {
        this.name = name;
    }

    public Subject(String name, List<Student> studentList) {
        this.name = name;
        this.studentList = studentList;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<Student> getStudentList() {
        return studentList;
    }

    public void setStudentList(List<Student> studentList) {
        this.studentList = studentList;
    }

    @Override
    public String toString() {
        return "Subject{" +
                "id=" + id +
                ", name='" + name + '\'' +
                '}';
    }
}
