package br.com.tcc.project.controller;

import br.com.portoseguro.payments.common.gateway.CommandGateway;
import br.com.tcc.project.command.FindAllCollege;
import br.com.tcc.project.command.RegisterCollege;
import br.com.tcc.project.command.mongo.model.CollegeDocument;
import br.com.tcc.project.controller.mapper.RegisterDisciplineControllerMapper;
import br.com.tcc.project.controller.request.RegisterCollegeRequest;
import br.com.tcc.project.exception.documentation.DocApiResponsesError;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;
import java.util.List;

@Tag(name = "Credit Card")
@RestController
@Slf4j
@Validated
public class CourseController {


  @Autowired @Setter private RegisterDisciplineControllerMapper registerDisciplineMapper;

  @Autowired @Setter private CommandGateway commandGateway;

  @Operation(summary = "Register new discipline", description = "Register new discipline")
  @DocApiResponsesError
  @PostMapping("discipline-equivalence/register-college")
  public ResponseEntity<Void> registerCollege(
      @Valid @RequestBody RegisterCollegeRequest request) {

    commandGateway.invoke(RegisterCollege.class, RegisterCollege.Request.builder().name(request.getName()).build());

    return ResponseEntity.ok().build();
  }

  @Operation(summary = "Find discipline by code", description = "Find discipline by code")
  @DocApiResponsesError
  @GetMapping("find-colleges")
  public ResponseEntity<List<CollegeDocument>> findAllColleges() {

    List<CollegeDocument> colleges = commandGateway.invoke(FindAllCollege.class, FindAllCollege.Request.builder().nothing("nothing").build());

    return ResponseEntity.ok(colleges);
  }


}
