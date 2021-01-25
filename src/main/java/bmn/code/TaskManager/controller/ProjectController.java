package bmn.code.TaskManager.controller;


import bmn.code.TaskManager.model.*;
import bmn.code.TaskManager.repository.ProjectCommentRepo;
import bmn.code.TaskManager.repository.ProjectRepo;
import bmn.code.TaskManager.repository.ProjectStepRepo;
import bmn.code.TaskManager.repository.StepRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.StreamSupport;

@Controller
public class ProjectController {

    private Long tempProjectId = null;

    @Autowired
    private ProjectRepo projectRepo;

    @Autowired
    private StepRepo stepRepo;

    @Autowired
    private ProjectStepRepo projectStepRepo;

    @Autowired
    private ProjectCommentRepo projectCommentRepo;

    @GetMapping("/")
    public String main(Map<String, Object> model) {

        return "loginPage";
    }

    @GetMapping("/projectMainView")
    public String project(@RequestParam(required = false, defaultValue = "") String filter,
                          @PageableDefault(sort = {"statusProject"}, direction = Sort.Direction.DESC, size = 5) Pageable pageable,
                          Model model) {
        tempProjectId = null;
        Iterable<Project> projects;
        Page<Project> pageProjects;

        if (filter != null && !filter.isEmpty()) {
            pageProjects = projectRepo.findByNumberProjectContaining(filter, pageable);
            projects = pageProjects.getContent();

        } else {
            pageProjects = projectRepo.findAll(pageable);
            projects = pageProjects.getContent();
        }

        Iterator<Project> projectIterator = projects.iterator();

        while (projectIterator.hasNext()) {

            Long projectId = projectIterator.next().getProjectId();
            Optional<Project> optionalProject = projectRepo.findById(projectId);
            Project project = null;
            if (optionalProject.isPresent()) {
                project = optionalProject.get();
            }

            Iterable<ProjectStep> projectStepIterable =
                    projectStepRepo.findAllProjectId(projectId);


            Iterable<ProjectComment> projectCommentIterable =
                    projectCommentRepo.findAllProjectId(projectId);

            Iterator<ProjectStep> projectStepIterator = projectStepIterable.iterator();

            Iterator<ProjectComment> projectCommentIterator = projectCommentIterable.iterator();


            boolean checkCompleteProjectSteps = StreamSupport.stream(
                    Spliterators
                            .spliteratorUnknownSize(projectStepIterator, Spliterator.NONNULL), false)
                    .allMatch(x -> x.getStatusStep().equals("complete"));

            boolean checkCompleteComments = StreamSupport.stream(
                    Spliterators
                            .spliteratorUnknownSize(projectCommentIterator, Spliterator.NONNULL), false)
                    .allMatch(x -> String.valueOf(x.getStatusComment()).equals("true"));

            assert project != null;
            if (checkCompleteProjectSteps && checkCompleteComments) {
                project.setStatusProject("complete");
                project.setDateFinishing(new SimpleDateFormat("dd-MM-yyyy").format(new Date()));
                projectRepo.save(project);
            } else {
                if (project.getStatusProject().equals("complete") &&
                        (checkCompleteComments == false || checkCompleteProjectSteps == false)) {
                    project.setStatusProject("in progress...");
                    project.setDateFinishing("-");
                }
            }
        }

        model.addAttribute("projects", projects);
        model.addAttribute("filter", filter);
        model.addAttribute("pageProjects", pageProjects);
        model.addAttribute("url", "/projectMainView");

        return "projectMainView";
    }

    @PostMapping("/renameProject")
    public String renameProject(@RequestParam Long projectId,
                                @RequestParam String numberProject,
                                @RequestParam String nameProject,
                                @RequestParam String revision) {


        Optional<Project> optionalProject = projectRepo.findById(projectId);
        if (optionalProject.isPresent()) {
            Project project = optionalProject.get();
            project.setNumberProject(numberProject);
            project.setNameProject(nameProject);
            project.setRevision(revision);
            projectRepo.save(project);
        }
        return "redirect:/steps";
    }

    @PostMapping("/deleteProject")
    public String deleteProject(@RequestParam Long id) {

        projectCommentRepo.deleteAll(projectCommentRepo.findAllProjectId(id));
        projectStepRepo.deleteAll(projectStepRepo.findAllProjectId(id));
        Optional<Project> optionalProject = projectRepo.findById(id);

        if (optionalProject.isPresent()) {
            Project project = optionalProject.get();
            projectRepo.delete(project);
        }

        return "redirect:/projectMainView";
    }


    @GetMapping("/steps")
    public String steps(@RequestParam(required = false) Long projectId, @RequestParam(required = false) Long id,
                        Model model) {

        Iterable<ProjectStep> step = null;

        Project project = null;

        Iterable<ProjectComment> projectComments = null;

        if (projectId != null) {

            tempProjectId = projectId;

            step = projectStepRepo.findAllProjectId(projectId);

            Optional<Project> optionalProject = projectRepo.findById(projectId);
            project = optionalProject.get();

            projectComments = projectCommentRepo.findAllProjectId(projectId);

        } else if (id != null) {

            Optional<ProjectStep> optionalProjectStep = projectStepRepo.findById(id);
            ProjectStep projectStep = optionalProjectStep.get();
            projectStep.setStatusStep("complete");
            projectStepRepo.save(projectStep);

            Long prjId = projectStepRepo.findProjectId(id);
            step = projectStepRepo.findAllProjectId(prjId);

            Optional<Project> optionalProject = projectRepo.findById(prjId);
            project = optionalProject.get();

            projectComments = projectCommentRepo.findAllProjectId(prjId);
        } else if (tempProjectId != null) {

            step = projectStepRepo.findAllProjectId(tempProjectId);

            Optional<Project> optionalProject = projectRepo.findById(tempProjectId);
            project = optionalProject.get();

            projectComments = projectCommentRepo.findAllProjectId(tempProjectId);
        }

        model.addAttribute("step", step);
        model.addAttribute("project", project);
        model.addAttribute("projectComments", projectComments);
        return "steps";
    }

    @GetMapping("/editSteps")
    public String editSteps(Model model) {

        Iterable<Step> editSteps = stepRepo.findAll(Sort.by(Sort.Direction.ASC, "id"));
        model.addAttribute("editSteps", editSteps);

        return "editSteps";
    }

    @PostMapping("/renameStep")
    public String renameStep(@RequestParam Long id, @RequestParam String stepName) {


        Optional<Step> optionalStep = stepRepo.findById(id);
        if (optionalStep.isPresent()) {
            Step oldStep = optionalStep.get();
            oldStep.setStepName(stepName);
            stepRepo.save(oldStep);
        }
        return "redirect:/editSteps";
    }

    @PostMapping("/deleteStep")
    public String deleteStep(@RequestParam Long id) {
        stepRepo.deleteById(id);
        return "redirect:/editSteps";
    }


    @PostMapping("/add")
    public String addProject(@AuthenticationPrincipal User user,
                             @RequestParam String numberProject,
                             @RequestParam String nameProject,
                             @RequestParam String revision,
                             Model model) {

        Project project = new Project(numberProject, nameProject, revision, user);

        Iterator<Step> iterator = stepRepo.findAll().iterator();

        projectRepo.save(project);

        while (iterator.hasNext()) {
            ProjectStep projectStep = new ProjectStep(iterator.next().getStepName(), "in progress...");
            projectStep.setProject(project);
            projectStepRepo.save(projectStep);
        }

        model.addAttribute("project", project);

        return "redirect:/projectMainView";
    }

    @PostMapping("/addStep")
    public String addStep(@RequestParam String stepName,
                          Map<String, Object> model) {

        Step step = new Step();
        step.setStepName(stepName);

        stepRepo.save(step);

        Iterable<Step> steps = stepRepo.findAll();

        model.put("steps", steps);

        return "redirect:/editSteps";
    }

    @PostMapping("/addComment")
    public String addComment(@RequestParam Long projectId, @RequestParam String comment, Model model) {

        Optional<Project> optionalProject = projectRepo.findById(projectId);
        Project projectCom = optionalProject.get();
        ProjectComment projectComment = new ProjectComment();
        projectComment.setComment(comment);
        projectComment.setStatusComment(false);
        projectComment.setProject(projectCom);
        projectCommentRepo.save(projectComment);
        return "redirect:/steps";
    }

    @PostMapping("/closeComment")
    public String closeComment(@RequestParam Long commentId, Model model) {

        Optional<ProjectComment> optionalProjectComment = projectCommentRepo.findById(commentId);
        ProjectComment projectComment = optionalProjectComment.get();
        projectComment.setStatusComment(true);
        projectCommentRepo.save(projectComment);

        Project project;

        if (tempProjectId != null) {
            Optional<Project> optionalProject = projectRepo.findById(tempProjectId);
            project = optionalProject.get();
            model.addAttribute("project", project);
        }
        return "redirect:/steps";

    }

}
