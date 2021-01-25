package bmn.code.TaskManager.model;


import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "project_steps")
public class ProjectStep {

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "project_id")
    private Project project;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "step_id")
    private Long id;

    @Column(name = "step_name", nullable = false)
    private String stepName;

    @Column(name = "status_step", nullable = false)
    private String statusStep;

    public ProjectStep() {
    }

    public ProjectStep(String stepName, String statusStep) {
        this.stepName = stepName;
        this.statusStep = statusStep;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getStepName() {
        return stepName;
    }

    public void setStepName(String stepName) {
        this.stepName = stepName;
    }

    public String getStatusStep() {
        return statusStep;
    }

    public void setStatusStep(String statusStep) {
        this.statusStep = statusStep;
    }

    public Project getProject() {
        return project;
    }

    public void setProject(Project project) {
        this.project = project;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ProjectStep that = (ProjectStep) o;
        return Objects.equals(stepName, that.stepName);
    }

    @Override
    public int hashCode() {
        return Objects.hash(stepName);
    }

    @Override
    public String toString() {
        return "ProjectStep{" +
                "project=" + project +
                ", id=" + id +
                ", stepName='" + stepName + '\'' +
                ", statusStep=" + statusStep +
                '}';
    }
}
