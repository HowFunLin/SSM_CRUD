package pers.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pers.bean.Employee;
import pers.bean.EmployeeExample;
import pers.dao.EmployeeMapper;

import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    private EmployeeMapper mapper;

    public List<Employee> findAll() {
        return mapper.selectByExampleWithDept(null);
    }

    public void save(Employee employee) {
        mapper.insertSelective(employee);
    }

    public boolean checkEmployee(String name) {
        EmployeeExample example = new EmployeeExample();
        example.createCriteria().andEmpNameEqualTo(name);

        return mapper.countByExample(example) == 0;
    }

    public Employee find(Integer id) {
        return mapper.selectByPrimaryKey(id);
    }

    public void update(Employee employee) {
        mapper.updateByPrimaryKeySelective(employee);
    }

    public void delete(Integer id) {
        mapper.deleteByPrimaryKey(id);
    }

    public void deleteBatch(List<Integer> ids) {
        EmployeeExample example = new EmployeeExample();
        example.createCriteria().andEmpIdIn(ids);
        mapper.deleteByExample(example);
    }
}
