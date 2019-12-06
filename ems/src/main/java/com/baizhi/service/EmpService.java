package com.baizhi.service;

import com.baizhi.entity.Emp;

import java.util.Map;

public interface EmpService {
    public Map<String, Object> queryByPage(Integer size, Integer page);

    public void add(Emp emp);

    public void update(Emp emp);

    public void delete(String id);
}
