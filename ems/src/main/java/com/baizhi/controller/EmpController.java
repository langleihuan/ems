package com.baizhi.controller;

import com.baizhi.entity.Emp;
import com.baizhi.service.EmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("emp")
public class EmpController {
    @Autowired
    private EmpService empService;

    @RequestMapping("queryAll")
    public Map queryAll(Integer rows, Integer page) {
        return empService.queryByPage(rows, page);
    }

    public void edit(String oper, Emp emp, String id) {
        if (oper.equals("add")) {
            empService.add(emp.setId(UUID.randomUUID().toString()));
        }
        if (oper.equals("edit")) {
            empService.update(emp);
        }
        if (oper.equals("del")) {
            empService.delete(id);
        }
    }
}
