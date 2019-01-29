package com.zcreate.security.auth;


import com.zcreate.security.dao.UserDao;
import com.zcreate.security.pojo.User;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;


@Service("customUserDetailsService")
public class CustomUserDetailsService implements UserDetailsService {
    Logger logger = Logger.getLogger(CustomUserDetailsService.class);
    //@Autowired
    private UserDao userDao;


    //@Transactional(readOnly = true)
    public UserDetails loadUserByUsername(String username)
            throws UsernameNotFoundException {
       System.out.println("userDao = " + userDao);
        List<User> user = userDao.getUserbyUsername(username);

        if (user == null || user.size() == 0) {
            throw new UsernameNotFoundException("用户名不存在！");
        }
        logger.debug("user:"+user.get(0).getUsername());

        /*logger.debug("User : " + user.get(0));
        logger.debug("User.isAccountNonExpired(): " + user.get(0).isAccountNonExpired());
        logger.debug("User.isAccountNonLocked(): " + user.get(0).isAccountNonLocked());
        logger.debug("User.isCredentialsNonExpired(): " + user.get(0).isCredentialsNonExpired());*/
        return user.get(0);
     /*   return new org.springframework.security.core.userdetails.User(user.get(0).getUsername(), user.get(0).getPassword(),
                user.get(0).isEnabled(), true, true, true,
                getGrantedAuthorities(user.get(0)));*/
    }


    private List<GrantedAuthority> getGrantedAuthorities(User user) {
        List<GrantedAuthority> authorities = new ArrayList<>();

     /*   for (UserProfile userProfile : user.getUserProfiles()) {
            System.out.println("UserProfile : " + userProfile);
            authorities.add(new SimpleGrantedAuthority("ROLE_" + userProfile.getType()));
        }*/
        authorities.add(new SimpleGrantedAuthority("ADMIN"));
        authorities.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
        logger.debug("authorities :" + authorities);
        return authorities;
    }

}
