package pers.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pers.bean.Department;
import pers.dao.DepartmentMapper;

import java.util.List;

@Service
public class DepartmentService {

    @Autowired
    private DepartmentMapper mapper;

    public List<Department> findAll()
    {
        return mapper.selectByExample(null);
    }
}
