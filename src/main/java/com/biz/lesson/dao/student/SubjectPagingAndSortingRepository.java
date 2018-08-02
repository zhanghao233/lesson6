package com.biz.lesson.dao.student;

import com.biz.lesson.model.student.Subject;
import org.springframework.data.repository.PagingAndSortingRepository;

/**
 *
 **/
public interface SubjectPagingAndSortingRepository extends PagingAndSortingRepository<Subject,Integer> {
}
