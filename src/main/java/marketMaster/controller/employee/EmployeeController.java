package marketMaster.controller.employee;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import marketMaster.bean.employee.EmpBean;
import marketMaster.bean.employee.RankLevelBean;
import marketMaster.exception.EmpDataAccessException;
import marketMaster.service.employee.EmployeeService;
import marketMaster.viewModel.EmployeeViewModel;

import org.springframework.web.bind.annotation.PostMapping;

@Controller
@RequestMapping("/employee")
public class EmployeeController {

	@Autowired
	private EmployeeService employeeService;
	
	@GetMapping("/empList")
	public String getAllEmployee(@RequestParam(defaultValue = "false") boolean showAll,
								@RequestParam(defaultValue = "0") int page,
								@RequestParam(defaultValue = "10") int size,
								Model model) {
		Page<EmpBean> employeePage  = employeeService.getAllEmployees(showAll, PageRequest.of(page, size));
		List<RankLevelBean> ranks = employeeService.getRankList();
		
	    model.addAttribute("employees", employeePage.getContent());
	    model.addAttribute("currentPage", page);
	    model.addAttribute("totalPages", employeePage.getTotalPages());
	    model.addAttribute("totalItems", employeePage.getTotalElements());
	    model.addAttribute("ranks", ranks);
	    model.addAttribute("showAll", showAll);
	    model.addAttribute("isSearchResult", false);
	    
		return "employee/EmployeeList";
	}
	
	@GetMapping("/empAddForm")
	public String showAddForm(Model model) {
		String newEmployeeId = employeeService.generateNewEmployeeId();
        model.addAttribute("newEmployeeId", newEmployeeId);
        model.addAttribute("emp", new EmpBean());
        model.addAttribute("positions", employeeService.getAllPositions());
        return "employee/AddEmployee";
	}
	
	@PostMapping("/empAdd")
	@ResponseBody
	public ResponseEntity<?> addEmployee(@ModelAttribute("emp") EmpBean emp, @RequestParam("file") MultipartFile file) {
	    try {
	        // 處理新增員工的邏輯
	        boolean success = employeeService.addEmployee(emp, file);
	        if (success) {
	            return ResponseEntity.ok().body("Employee added successfully");
	        } else {
	            return ResponseEntity.badRequest().body("Failed to add employee");
	        }
	    } catch (Exception e) {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error: " + e.getMessage());
	    }
	}
	
	@GetMapping("/search")
	public String searchEmployees(@RequestParam String searchName, @RequestParam(defaultValue = "false") boolean showAll, Model model) {
	    List<EmpBean> employees = employeeService.searchEmployees(searchName, showAll);
	    model.addAttribute("employees", employees);
	    model.addAttribute("showAll", showAll);
	    model.addAttribute("isSearchResult", true);
	    return "employee/EmployeeList";
	}
	
	@GetMapping("/details")
	public String showEmployeeDetails(@RequestParam String employeeId, Model model) {
	    EmployeeViewModel employee = employeeService.getEmployeeViewModel(employeeId);
	    model.addAttribute("employee", employee);
	    return "employee/EmployeeDetails";
	}
	
    @GetMapping("/getUpdate")
    public String getEmployeeForUpdate(@RequestParam String employeeId, Model model) {
            EmployeeViewModel empViewModel = employeeService.getEmployeeViewModel(employeeId);
            model.addAttribute("employeeToUpdate", empViewModel);
            model.addAttribute("positions", employeeService.getAllPositions());
            return "employee/UpdateEmployee";
    }
	
    @PostMapping("/empUpdate")
    public String updateEmployee(@ModelAttribute("emp") EmpBean emp, 
                                 @RequestParam(value = "file", required = false) MultipartFile file,
                                 RedirectAttributes redirectAttributes) {
        try {
            boolean success = employeeService.updateEmployee(emp, file);
            if (success) {
            	redirectAttributes.addFlashAttribute("message", "員工更新成功");
            	return "redirect:/employee/details?employeeId=" + emp.getEmployeeId();
            } else {
            	redirectAttributes.addFlashAttribute("message", "更新失敗，員工不存在");
            	return "redirect:/employee/empList";
            }
        } catch (EmpDataAccessException e) {
        	redirectAttributes.addFlashAttribute("message", "更新失敗：" + e.getMessage());
        }
        return "redirect:/employee/empList";
    }
	
    @GetMapping("/delete")
    public String deleteEmployee(@RequestParam String employeeId, RedirectAttributes redirectAttributes) {
        boolean deleted = employeeService.deleteEmployee(employeeId);
        if (deleted) {
            redirectAttributes.addFlashAttribute("message", "員工已成功刪除");
        } else {
            redirectAttributes.addFlashAttribute("error", "刪除員工時出錯");
        }
        return "redirect:/employee/empList";
    }
}
