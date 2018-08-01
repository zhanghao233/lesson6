package com.biz.lesson.dao.student;

import com.biz.lesson.model.student.Grade;
import com.biz.lesson.model.student.Student;
import org.springframework.data.repository.PagingAndSortingRepository;

/**
 *
 **/
public interface GradePagingAndSortingRepository extends PagingAndSortingRepository<Grade,Integer> {
}
