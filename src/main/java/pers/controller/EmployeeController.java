package pers.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import pers.bean.Employee;
import pers.service.EmployeeService;
import pers.utils.Message;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService service;

    @RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
    public @ResponseBody Message deleteEmployee(@PathVariable("ids") String ids)
    {
        if (ids.contains("-"))
        {
            List<Integer> empIds = new ArrayList<>();
            String[] strs = ids.split("-");

            for (String str : strs)
                empIds.add(Integer.parseInt(str));

            service.deleteBatch(empIds);
        }else {
            Integer id = Integer.parseInt(ids);
            service.delete(id);
        }

        return Message.succeed();
    }

    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    public @ResponseBody Message updateEmployee(Employee employee)
    {
        service.update(employee);
        return Message.succeed();
    }

    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    public @ResponseBody Message getEmployee(@PathVariable("id") Integer id) {
        Employee employee = service.find(id);

        return Message.succeed().add("employee", employee);
    }

    @RequestMapping("/checks")
    public @ResponseBody Message checkEmployee(@RequestParam("empName") String name) {
        String regexEng = "^[a-zA-Z-]{6,16}$";
        String regexChn = "(^[\u2E80-\u9FFF]{2,6}$)";;

        if (!name.matches(regexEng) && !name.matches(regexChn))
            return Message.fail().add("check", "Illegal Name!");

        boolean isAvailable = service.checkEmployee(name);

        return isAvailable ? Message.succeed() : Message.fail().add("check", "Duplicate Name!");
    }

    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    public @ResponseBody
    Message saveEmployee(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors())
        {
            Map<String, String> map = new HashMap<>();
            List<FieldError> fieldErrors = result.getFieldErrors();

            for (FieldError error : fieldErrors)
                map.put(error.getField(), error.getDefaultMessage());

            return Message.fail().add("errors", map);
        }
        else {
            service.save(employee);
            return Message.succeed();
        }
    }

    @RequestMapping("/emps")
    public @ResponseBody
    Message getEmployeeJsonWithMsg(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 5); // 页面大小5条记录
        //只有紧跟在PageHelper.startPage方法后的第一个Mybatis的查询（Select）方法会被分页
        List<Employee> employees = service.findAll(); // 动态拼接SQL
        PageInfo pageInfo = new PageInfo(employees, 5); // 分页条最多显示5个页码

        return Message.succeed().add("pageInfo", pageInfo);// 返回一个有状态码、操作信息和PageInfo对象的Message对象的JSON字符串
    }

    //    @RequestMapping("/emps") // 无法返回其他状态信息，可自定义Message类实现
//    public @ResponseBody
//    PageInfo getEmployeeJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
//        PageHelper.startPage(pn, 5); // 页面大小5条记录
//        //只有紧跟在PageHelper.startPage方法后的第一个Mybatis的查询（Select）方法会被分页
//        List<Employee> employees = service.findAll(); // 动态拼接SQL
//        PageInfo pageInfo = new PageInfo(employees, 5); // 分页条最多显示5个页码
//
//        return pageInfo;
//    }

    //    @RequestMapping("/emps")
//    public String getEmployee(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
//        PageHelper.startPage(pn, 5); // 页面大小5条记录
//        //只有紧跟在PageHelper.startPage方法后的第一个Mybatis的查询（Select）方法会被分页
//        List<Employee> employees = service.findAll(); // 动态拼接SQL
//        PageInfo pageInfo = new PageInfo(employees, 5); // 分页条最多显示5个页码
//
//        model.addAttribute("pageInfo", pageInfo);
//
//        return "list";
//    }
}