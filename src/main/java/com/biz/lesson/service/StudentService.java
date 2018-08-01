package com.biz.lesson.service;

import com.biz.lesson.dao.student.StudentCrudRepository;
import com.biz.lesson.dao.student.StudentJpaRepository;
import com.biz.lesson.dao.student.StudentPagingAndSortingRepository;
import com.biz.lesson.dao.student.StudentRepository;
import com.biz.lesson.model.student.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 **/

@Service
public class StudentService {

    @Autowired
    private StudentRepository studentRepository;
    @Autowired
    private StudentCrudRepository studentCrudRepository;
    @Autowired
    private StudentJpaRepository studentJpaRepository;
    @Autowired
    private StudentPagingAndSortingRepository studentPagingAndSortingRepository;
    @Transactional
    public void update(Integer id,String name){
        studentRepository.update(id,name);
    }
    @Transactional
    public void update1(Integer id,String name){
        studentRepository.update1(id,name);
    }
    @Transactional
    public void deleteById(Integer id){
        studentRepository.deleteById(id);
    }
    @Transactional
    public void deleteById1(Integer id){
        studentRepository.deleteById1(id);
    }

    @Transactional
    public  void  save(List<Student> students){
        studentCrudRepository.save(students);
    }
    @Transactional
    public  void  deleteAll(){
        studentCrudRepository.deleteAll();
    }

    public List<Student> findAll() {
        return studentJpaRepository.findAll();
    }
    public Page<Student> pageList(Integer number) {
        Pageable pageable = new PageRequest(number,10   );
        Page<Student> page = studentPagingAndSortingRepository.findAll(pageable);
        return page;
    }
    public List<Student> searchByName(String name){
        return studentRepository.queryLike1(name);
    }
    public List<Student> findByCodeStartWith(String code){
        return studentRepository.findByCodeStartingWith(code);
    }

    public List<Student> searchBirthday(String birthday){
        List<Student> students = studentJpaRepository.findAll();
        List<Student> studentList = new ArrayList<Student>();
        for (Student student:students) {
            Date date = student.getBirthday();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String formatBirthday = sdf.format(date);
            if(formatBirthday.equals(birthday)){
                studentList.add(student);
            }
        }
            return studentList;
    }

    public List<Student> findByBirthdayBetween(Date lastBirthday,Date nextBirthday){
        return  studentRepository.findByBirthdayBetween(lastBirthday,nextBirthday);
    }
}
