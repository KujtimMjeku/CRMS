package com.crms.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.crms.entity.UserGroup;
import com.crms.repository.UsersRepository;

@Controller
@RequestMapping("/accounts/groups")
public class GroupController {
	
	@Autowired
	UsersRepository repo;
	
	@RequestMapping("/")
	private String goHome(Model model)
	{
		Set<UserGroup> groups= repo.findAllGroups();
		List<Integer> p=new ArrayList<>();
		p.add(1);
		p.add(2);
		p.add(3);
		model.addAttribute("morePage", true);
		model.addAttribute("pList", p);
		model.addAttribute("records_count", 10);
		model.addAttribute("groups", groups);
		return "tables/tbl_groups";
	}
	@RequestMapping(value="/delete/{id}",method = RequestMethod.POST)
	private String goDelete(Model model,@PathVariable("id") int id)
	{
		System.out.println("Id : "+ id);
		return "redirect:/accounts/groups/";
	}

}
