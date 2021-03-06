package com.sayee.sxsy.api.organ.service;

import com.sayee.sxsy.api.organ.dao.OrganDao;
import com.sayee.sxsy.api.organ.entity.Organ;
import com.sayee.sxsy.api.organ.entity.OrganUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Description
 */
@Service
public class OrganApiService {
    @Autowired
    private OrganDao organDao;
    public Organ getOrgan(){
       return organDao.getOrgan();
    }
    public Organ connectUs(){
        return organDao.connectUs();
    }
    public List<OrganUser> getUserList(String[] idList){
        return organDao.getUserList(idList);
    }
}
