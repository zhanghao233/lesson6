package com.biz.lesson.service;

import com.biz.lesson.dao.student.GradeCrudRepository;
import com.biz.lesson.dao.student.GradePagingAndSortingRepository;
import com.biz.lesson.dao.student.GradeRepository;
import com.biz.lesson.model.student.Grade;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

/**
 * 班级管理
 **/
@Service
public class GradeService {

    @Autowired
    private GradeRepository gradeRepository;
    @Autowired
    private GradeCrudRepository gradeCrudRepository;
    @Autowired
    private GradePagingAndSortingRepository gradePagingAndSortingRepository;
    public void save(List<Grade> gradeList){
        gradeCrudRepository.save(gradeList);

    }
    @Transactional
    public Page<Grade> pageList(Integer number) {
        Pageable pageable = new PageRequest(number,10    );
        Page<Grade> page = gradePagingAndSortingRepository.findAll(pageable);
        return page;
    }
    @Transactional
    public void deleteAll(){
        gradeCrudRepository.deleteAll();
    }

}
