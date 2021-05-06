package pers.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import pers.bean.Department;
import pers.service.DepartmentService;
import pers.utils.Message;

import java.util.List;

@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService service;

    @RequestMapping("/depts")
    public @ResponseBody Message getDepartment()
    {
        List<Department> departments = service.findAll();

        return Message.succeed().add("depts", departments);
    }
}
