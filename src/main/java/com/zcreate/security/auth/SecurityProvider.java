package com.zcreate.security.auth;

import com.zcreate.security.dao.UserDao;
import com.zcreate.security.pojo.User;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import java.util.List;

/**
 * Created by hhy on 17-5-20.
 */
public class SecurityProvider implements AuthenticationProvider {
    Logger logger = Logger.getLogger(SecurityProvider.class);

    @Autowired
    private UserDao userDao;

  /*  public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }*/

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        //UsernamePasswordAuthenticationToken token = (UsernamePasswordAuthenticationToken) authentication;
        logger.debug("auth.getName()=" + authentication.getName());
        logger.debug("auth.getCredentials()=" + authentication.getCredentials().toString());
        logger.debug("userDao=" + userDao);

        List<User> user = userDao.getUserbyUsername(authentication.getName());
        if (user == null || user.size() == 0) {
            throw new UsernameNotFoundException("用户名不存在");
        }
        if(!user.get(0).getPassword().equals( authentication.getCredentials().toString()))
            throw new BadCredentialsException("密码错误");

        return new UsernamePasswordAuthenticationToken(user.get(0), authentication.getCredentials(), user.get(0).getAuthorities());
    }

    @Override
    public boolean supports(Class<?> authentication) {
        // TODO Auto-generated method stub
        return UsernamePasswordAuthenticationToken.class.equals(authentication);
    }
}