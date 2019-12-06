package com.baizhi.service;

import com.baizhi.dao.EmpDao;
import com.baizhi.entity.Emp;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

@Service
@Transactional
public class EmpServiceImpl implements EmpService {
    @Autowired
    private EmpDao empDao;

    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public Map<String, Object> queryByPage(Integer size, Integer page) {
        Map<String, Object> map = new HashMap<>();
        Integer count = empDao.selectCount(new Emp());
        Integer totalPage = 0;
        if (count % size == 0) {
            totalPage = count / size;
        } else {
            totalPage = count / size + 1;
        }
        Integer start = (page - 1) * size;
        map.put("records", count);
        map.put("page", page);
        map.put("total", totalPage);
        map.put("rows", empDao.selectByRowBounds(new Emp(), new RowBounds(start, size)));
        return map;
    }

    @Override
    public void add(Emp emp) {
        empDao.insert(emp);
    }

    @Override
    public void update(Emp emp) {
        empDao.updateByPrimaryKeySelective(emp);
    }

    @Override
    public void delete(String id) {
        empDao.deleteByPrimaryKey(id);
    }
}
