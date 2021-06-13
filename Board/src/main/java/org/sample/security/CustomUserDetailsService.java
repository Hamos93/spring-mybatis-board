package org.sample.security;

import org.sample.domain.MemberVO;
import org.sample.mapper.MemberMapper;
import org.sample.security.domain.CustomUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {
	
	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

		log.warn("Load User By UserName: " + username);
		
		// username means userid
		MemberVO member = mapper.read(username);
		
		log.warn("queried by member mapper: " + member);
		
		return member == null ? null : new CustomUser(member);
	}
	
}
