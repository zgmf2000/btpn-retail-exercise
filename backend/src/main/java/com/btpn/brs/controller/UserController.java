package com.btpn.brs.controller;

import com.btpn.persistence.entity.brs.RoleEntity;
import com.btpn.persistence.entity.brs.UserEntity;
import com.btpn.persistence.service.role.RoleDAOService;
import com.btpn.persistence.service.user.UserDAOService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/**
 * Created by Bintoro on 5/10/2017.
 */
@RestController
@RequestMapping(path="/user")
public class UserController {
    @Autowired
    private UserDAOService userDAOService;

    @Autowired
    private RoleDAOService roleDAOService;

    @RequestMapping(value = "/all", method = RequestMethod.GET)
    private ResponseEntity<Iterable<UserEntity>> getAllUsers(@RequestParam(value = "role_id", required = false) Long id) {
        if (id != null)
        {
            RoleEntity role = roleDAOService.findOne(id);
            return new ResponseEntity<>(role.getUsers(), HttpStatus.OK);
        }
        else
            return new ResponseEntity<>(userDAOService.findAll(), HttpStatus.OK);
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    private ResponseEntity<UserEntity> getUser(@PathVariable long id) {
        return new ResponseEntity<>(userDAOService.findOne(id), HttpStatus.OK);
    }
}