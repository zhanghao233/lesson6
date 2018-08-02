package com.biz.lesson.service;

import com.biz.lesson.dao.student.SubjectCrudRepository;
import com.biz.lesson.dao.student.SubjectPagingAndSortingRepository;
import com.biz.lesson.dao.student.SubjectRepository;
import com.biz.lesson.model.student.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.math.BigInteger;
import java.util.List;
@Service
public class SubjectService {

    @Autowired
    private SubjectRepository subjectRepository;
    @Autowired
    private SubjectCrudRepository subjectCrudRepository;
    @Autowired
    private SubjectPagingAndSortingRepository subjectPagingAndSortingRepository;

    public void save(List<Subject> subjectList){
        subjectCrudRepository.save(subjectList);
    }
    @Transactional
    public Page<Subject> pageList(Integer number) {
        Pageable pageable = new PageRequest(number,10    );
        Page<Subject> page = subjectPagingAndSortingRepository.findAll(pageable);
        return page;
    }
    @Transactional
    public List<String> findAllname(){
        return  subjectRepository.findAllname();
    }
    @Transactional
    public List<BigInteger> findNumByName(){
        return  subjectRepository.findNumByName();
    }
}
