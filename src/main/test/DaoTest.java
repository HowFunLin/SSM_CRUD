import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import pers.bean.Employee;
import pers.dao.DepartmentMapper;
import pers.dao.EmployeeMapper;

import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class DaoTest {

    @Autowired
    private DepartmentMapper departmentMapper;

    @Autowired
    private EmployeeMapper employeeMapper;

    @Autowired
    private SqlSession sqlSession;

    @Test
    public void test() {
//        departmentMapper.insertSelective(new Department(null, "开发部"));
//        departmentMapper.insertSelective(new Department(null, "测试部"));

//        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
//
//        for (int i = 0; i < 1000; i++)
//        {
//            String name = UUID.randomUUID().toString().substring(0, 5);
//            mapper.insertSelective(new Employee(null, name, "M", name + "@qq.com", 1));
//        }
    }
}
