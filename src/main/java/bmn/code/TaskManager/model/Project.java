package bmn.code.TaskManager.model;

import org.springframework.lang.NonNull;

import javax.persistence.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.Set;

/*
класс описывающий такую сущность как проект
 */

@Entity
@Table(name = "projects")
public class Project {

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    private User developer;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "project_id")
    private Long projectId;

    /*
    номер проекта, обычно  вида #8080
     */
    @Column(name = "number_project", nullable = false)
    private String numberProject;

    /*
    название проекта
     */
    @Column(name = "name_project")
    private String nameProject;

    /*
    текущая ревизия
     */
    @Column(name = "revision")
    private String revision;

    /*
    дата начала работы над проектом
     */
    @Column(name = "date_create", nullable = false)
    private String dateCreate;

    /*
    дата завершения работы над проектом
     */
    @Column(name = "date_finishing")
    private String dateFinishing;

    /*
    любое текстовое сопровождение по проекту
     */
    @Column(name = "description")
    private String description;

    /*
    статус проекта, завершен или нет
     */
    @Column(name = "status_project")
    private String statusProject;

    public Project() {
    }

    public String getDeveloperName() {
        return developer != null ? developer.getLastname() : "<none>";
    }


    /*
        конструктор для инициализации проескта при его создании
     */
    public Project(String numberProject, String nameProject, String revision,
                   User user) {
        this.developer = user;
        this.numberProject = numberProject;
        this.nameProject = nameProject;
        this.revision = revision;
        dateCreate = new SimpleDateFormat("dd-MM-yyyy").format(new Date());
        dateFinishing = "-";
        description = "-";
        statusProject = "in progress...";
    }

    public String getStatusProject() {
        return statusProject;
    }

    public void setStatusProject(String statusProject) {
        this.statusProject = statusProject;
    }

    public Long getProjectId() {
        return projectId;
    }

    public void setProjectId(Long projectId) {
        this.projectId = projectId;
    }

    public String getNumberProject() {
        return numberProject;
    }

    public void setNumberProject(String numberProject) {
        this.numberProject = numberProject;
    }

    public String getNameProject() {
        return nameProject;
    }

    public void setNameProject(String nameProject) {
        this.nameProject = nameProject;
    }

    public String getRevision() {
        return revision;
    }

    public void setRevision(String revision) {
        this.revision = revision;
    }

    public String getDateCreate() {
        return dateCreate;
    }

    public void setDateCreate(String dateCreate) {
        this.dateCreate = dateCreate;
    }

    public String getDateFinishing() {
        return dateFinishing;
    }

    public void setDateFinishing(String dateFinishing) {
        this.dateFinishing = dateFinishing;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public User getDeveloper() {
        return developer;
    }

    public void setDeveloper(User developer) {
        this.developer = developer;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Project project = (Project) o;
        return Objects.equals(numberProject, project.numberProject) &&
                Objects.equals(nameProject, project.nameProject) &&
                Objects.equals(revision, project.revision);
    }

    @Override
    public int hashCode() {
        return Objects.hash(numberProject, nameProject, revision);
    }

    @Override
    public String toString() {
        return "Project{" +
                ", developer=" + developer +
                ", projectId=" + projectId +
                ", numberProject='" + numberProject + '\'' +
                ", nameProject='" + nameProject + '\'' +
                ", revision='" + revision + '\'' +
                ", dateCreate='" + dateCreate + '\'' +
                ", dateFinishing='" + dateFinishing + '\'' +
                ", description='" + description + '\'' +
                ", statusProject='" + statusProject + '\'' +
                '}';
    }
}
