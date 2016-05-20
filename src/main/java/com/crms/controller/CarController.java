package com.crms.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.constraints.Size;
import javax.websocket.server.PathParam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PostAuthorize;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.portlet.ModelAndView;

import com.crms.dao.CarDAO;
import com.crms.dao.CarTypeDAO;
import com.crms.entity.Car;
import com.crms.entity.CarType;
import com.crms.entity.User;
import com.crms.repository.UsersRepository;
import com.crms.services.CarService;
import com.crms.services.UserGrupService;

@Controller
@RequestMapping(value="car") 
@SessionAttributes({ "page", "perPage"})
public class CarController {
	
	@Autowired
	private CarDAO carDao;
	@Autowired
	private CarTypeDAO cartypeDao;
	
	@Autowired
	private UserGrupService usr;
	
	@Autowired
	private CarService carService;

	@Autowired
	private UsersRepository uRep;
	
	  @ModelAttribute("page")
	    public Integer createPge() {
	        return 1;
	    }
	  @ModelAttribute("perPage")
	    public Integer createPerPage() {
	        return 10;
	    }
	

	@RequestMapping(value="/", method = RequestMethod.GET) 

	public String goHome(Model model,@ModelAttribute("page") int page
			,@ModelAttribute("perPage") int perPage) {

		//User user=(User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		User u=new User();
		u.setUsername("TeT");
		u.setPassword("123");
		u.setEmail("kuj1ta@gmail.com");
		u.setEnabled(true);
		uRep.saveUser(u);
	//	System.out.println("Email : " +user.getEmail());
		int rows=Math.toIntExact(carService.getRecordNumber());	
		List<Car> cars=(List<Car>) carService.getPage(page, perPage);		
		Map<Integer,String> fotot=new HashMap<>();	
		for (Car c:cars) {
			if(!(c.getImage() == null))
			{
				fotot.put(c.getId(), Base64.getEncoder().encodeToString(c.getImage()));
			}
			else
			{
				fotot.put(c.getId(),"33");
			}
		}
		
		model.addAttribute("cars", cars);
		model.addAttribute("foto", fotot);
		model.addAttribute("actualpage", page);
		
		model.addAttribute("records_count", carService.getRecordNumber());
		
		List<Integer> p=carService.getPagingButtons(page,perPage,Math.toIntExact(carService.getRecordNumber()), 4);
		
		boolean morePage=(rows/perPage)+1>p.get(p.size() - 1);
		
		model.addAttribute("morePage", morePage);
		model.addAttribute("pList", p);
		model.addAttribute("cartypee", new Car());
		/*UserDetails userDetails =
				 (UserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
*/
	//	System.out.println(SecurityContextHolder.getContext().getAuthentication().getPrincipal());
	//	User user= (User) SecurityContextHolder.getContext().getAuthentication();
		//System.out.println(user.getPassword());
		model.addAttribute("username", SecurityContextHolder.getContext().getAuthentication().getName());
		return "pages/car";
	}
	@RequestMapping(value="/page/{page}", method = RequestMethod.GET) 
	public String goPage(Model model,@PathVariable(value="page") int page,@ModelAttribute("perPage") int perPage) {		
		model.addAttribute("page", page);
		
		System.out.println("page: "+page+" perPage: "+perPage);
		int rows=Math.toIntExact(carService.getRecordNumber());	
		List<Car> cars=(List<Car>) carService.getPage(page, perPage);		
		Map<Integer,String> fotot=new HashMap<>();	
		for (Car c:cars) {
			if(!(c.getImage() == null))
			{
				fotot.put(c.getId(), Base64.getEncoder().encodeToString(c.getImage()));
			}
			else
			{
				fotot.put(c.getId(),"33");
			}
		}
		
		model.addAttribute("cars", cars);
		model.addAttribute("foto", fotot);
		model.addAttribute("actualpage", page);
		
		model.addAttribute("records_count", carService.getRecordNumber());
		
		List<Integer> p=carService.getPagingButtons(page,perPage,Math.toIntExact(carService.getRecordNumber()), 4);
		boolean morePage = false;
		if(rows%perPage != 0)
		{
			morePage=(rows/perPage)+1>p.get(p.size() - 1);
		}
		else
		{
			morePage=(rows/perPage)>p.get(p.size() - 1);
		}
		
		model.addAttribute("morePage", morePage);
		model.addAttribute("pList", p);
		model.addAttribute("cartypee", new Car());
		System.out.println(SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		model.addAttribute("username", SecurityContextHolder.getContext().getAuthentication().getName());
		return "pages/car";
	}
	@RequestMapping(value="/perpage/", method = RequestMethod.GET) 
	public @ResponseBody String goPP(Model model,@RequestParam("perPage") int perPage) {		
		model.addAttribute("perPage", perPage);
		model.addAttribute("page", 1);
		System.out.println("test");
		return "succes";
	}
	
	
	@RequestMapping(value="/add", method = RequestMethod.GET) 
	public String goAdd(Model model) {		
		model.addAttribute("car", new Car());
		model.addAttribute("button", "Save");
		List<String> ctname=cartypeDao.getCarNames();
		model.addAttribute("ctname", ctname);
		model.addAttribute("cttype", new ArrayList<String>());
		model.addAttribute("ctautomatic","BOTH");
		model.addAttribute("saveUrl","add");
		return "pages/car_edit_frm";
	}
	@RequestMapping(value="/edit/{id}", method = RequestMethod.GET) 
	@PostAuthorize("hasPermission(#model['car'], 'read')")
	public String goEdit(Model model,@PathVariable(value="id") int id) {
		Car car=carDao.findOne(id);
		model.addAttribute("car", car);
		if(car.getImage() != null)
		{
			model.addAttribute("image", Base64.getEncoder().encodeToString(car.getImage()));
		}
		model.addAttribute("button", "Update");
		List<String> ctname=cartypeDao.getCarNames();
		List<String> cttype=cartypeDao.getCarTypesByName(car.getTblcarType().getName());
		List<Boolean> ctautomatic=cartypeDao.getCarAutomaticByNameAndType(
				car.getTblcarType().getName(),
				car.getTblcarType().getType());
		System.out.println(ctautomatic);
		String t =getAutomatic(ctautomatic);
		model.addAttribute("ctname", ctname);
		model.addAttribute("cttype", cttype);
		model.addAttribute("ctautomatic",t);
		model.addAttribute("saveUrl","update");
		return "pages/car_edit_frm";
	}
	
	@RequestMapping(value="/view/{id}", method = RequestMethod.GET) 
	public String goView(Model model,@PathVariable(value="id") int id) {
		Car car=carDao.findOne(id);
		model.addAttribute("car", car);
		String image;
		if(!(car.getImage() == null))
		{
			 image= Base64.getEncoder().encodeToString(car.getImage());
		}
		else
		{
			image="33";
		}
		model.addAttribute("image", image);
		return "pages/view_car";
	}
	
	
	
	@RequestMapping(value="/json/types", method = RequestMethod.GET) 
	public @ResponseBody List<String> getTypes(@PathParam("name") String name) {		
		List<String> cttype=cartypeDao.getCarTypesByName(name);
		return cttype;
	}
	
	@RequestMapping(value="/json/automatic", method = RequestMethod.GET) 
	public @ResponseBody String getAutomatic(@PathParam("name") String name,@PathParam("type") String type) {		
		List<Boolean> cttype=cartypeDao.getCarAutomaticByNameAndType(name, type);
		return getAutomatic(cttype);
	}
	
	@RequestMapping(value="/add", method = RequestMethod.POST) 
	public String goSave(Model model,
			@ModelAttribute Car car,
			@RequestParam(name="file") MultipartFile[] files) {	
		
		System.out.println(car);
		CarType ct=cartypeDao.getCarTypeByNameAndTypeAndAutomatic(
				car.getTblcarType().getName(),
				car.getTblcarType().getType(), 
				car.getTblcarType().getAutomatic());
		car.setTblcarType(ct);
		car.setImage_name(files[0].getOriginalFilename());
		try {
			car.setImage(files[0].getBytes());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Car c=carDao.save(car);
		System.out.println(c);
		return "redirect:/car/";
	}
	
	@RequestMapping(value="/update/{id}", method = RequestMethod.POST) 
	@PreAuthorize("hasPermission(#car,'write')")
	public String goUpdate(Model model,@ModelAttribute Car car,@RequestParam(name="file") MultipartFile[] files,@PathVariable("id") int id) {	
		
		System.out.println(car);
		System.out.println(car.getTblcarType());
		System.out.println(car.getTblcarType().getAutomatic());
		CarType ct=cartypeDao.getCarTypeByNameAndTypeAndAutomatic(
				car.getTblcarType().getName(),
				car.getTblcarType().getType(), 
				car.getTblcarType().getAutomatic());
		car.setImage_name(files[0].getOriginalFilename());
		try {
			car.setImage(files[0].getBytes());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		car.setTblcarType(ct);
		Car c=carDao.save(car);
		System.out.println("test"+c);
		return "redirect:/car/";
	}
	
	public static String  getAutomatic(List<Boolean> array)
	{
		boolean tr=true;
		boolean fs=true;;
	    for(boolean b : array) if(!b) {tr=false; break;}
	    for(boolean b : array) if(b) {fs=false; break;}
	    if(!tr && !fs)
	    {
	    	 return "BOTH";
	    }
	    else if(tr)
	    {
	    	 return "TRUE";
	    }
	    else if(fs)
	    {
	    	 return "FALSE";
	    }
	    return "NONE";
	}
	
	@RequestMapping(value="/pdf/", method = RequestMethod.GET) 
	public String pdfCarReport(Model model,HttpSession session)
	{
		System.out.println("test");
		List<Car> carlist = carService.getPage((int)session.getAttribute("page"), (int)session.getAttribute("perPage"));
		 model.addAttribute("carList",carlist);
		return "PdfCarReprot";
	}
}
