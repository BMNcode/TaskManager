package bmn.code.TaskManager.repository;

import bmn.code.TaskManager.model.Step;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;

public interface StepRepo extends JpaRepository<Step, Long> {

}
