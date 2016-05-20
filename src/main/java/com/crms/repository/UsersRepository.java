package com.crms.repository;

import java.util.List;
import java.util.Set;

import org.springframework.data.repository.CrudRepository;

import com.crms.dto.UserDto;
import com.crms.entity.User;
import com.crms.entity.UserGroup;

public interface UsersRepository
{
	User findUserNyUsername(String username);
	List<User> findAllUsers();
	void saveUser(User user);
	User updateUser(UserDto user);
	Set<UserGroup> findAllGroups();
	UserGroup findUserGroupById(Integer id);
	String saveUser(UserDto user);
}
