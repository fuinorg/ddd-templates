package org.fuin.dsl.ddd.gen.base;

import com.google.common.base.Objects;
import java.util.ArrayList;
import java.util.List;
import org.eclipse.emf.common.util.EList;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractVO;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.ConstructorData;
import org.fuin.dsl.ddd.gen.base.SrcConstructorWithParamsAssignment;
import org.fuin.dsl.ddd.gen.extensions.CollectionExtensions;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates source code for a number of constructors with
 * all parameters assigned to an instance variable.
 */
@SuppressWarnings("all")
public class SrcConstructorsWithParamsAssignment implements CodeSnippet {
  private final CodeSnippetContext ctx;
  
  private final List<ConstructorData> constructors;
  
  /**
   * Constructor with entity.
   * 
   * @param ctx Context.
   * @param entity Entity.
   */
  public SrcConstructorsWithParamsAssignment(final CodeSnippetContext ctx, final AbstractEntity entity) {
    this.ctx = ctx;
    ArrayList<ConstructorData> _arrayList = new ArrayList<ConstructorData>();
    this.constructors = _arrayList;
    EList<Constructor> _constructors = entity.getConstructors();
    List<Constructor> _nullSafe = CollectionExtensions.<Constructor>nullSafe(_constructors);
    for (final Constructor con : _nullSafe) {
      String _name = entity.getName();
      ConstructorData _constructorData = new ConstructorData("public", _name, con);
      this.constructors.add(_constructorData);
    }
  }
  
  /**
   * Constructor with value object.
   * 
   * @param ctx Context.
   * @param vo Value object.
   */
  public SrcConstructorsWithParamsAssignment(final CodeSnippetContext ctx, final AbstractVO vo) {
    this.ctx = ctx;
    ArrayList<ConstructorData> _arrayList = new ArrayList<ConstructorData>();
    this.constructors = _arrayList;
    String _name = vo.getName();
    ConstructorData _constructorData = new ConstructorData("/** Default constructor. */", "protected", _name, null, null);
    this.constructors.add(_constructorData);
    boolean _or = false;
    EList<Constructor> _constructors = vo.getConstructors();
    boolean _equals = Objects.equal(_constructors, null);
    if (_equals) {
      _or = true;
    } else {
      EList<Constructor> _constructors_1 = vo.getConstructors();
      int _size = _constructors_1.size();
      boolean _equals_1 = (_size == 0);
      _or = _equals_1;
    }
    if (_or) {
      String _name_1 = vo.getName();
      EList<Variable> _variables = vo.getVariables();
      ConstructorData _constructorData_1 = new ConstructorData("/** Constructor with all data. */", "public", _name_1, _variables, null);
      this.constructors.add(_constructorData_1);
    } else {
      EList<Constructor> _constructors_2 = vo.getConstructors();
      List<Constructor> _nullSafe = CollectionExtensions.<Constructor>nullSafe(_constructors_2);
      for (final Constructor con : _nullSafe) {
        String _name_2 = vo.getName();
        ConstructorData _constructorData_2 = new ConstructorData("public", _name_2, con);
        this.constructors.add(_constructorData_2);
      }
    }
  }
  
  /**
   * Constructor with all mandatory data.
   * 
   * @param ctx Context.
   * @param typeName Name of the type the constructors creates.
   * @param constructors Constructors.
   */
  public SrcConstructorsWithParamsAssignment(final CodeSnippetContext ctx, final String typeName, final List<ConstructorData> constructorData) {
    this.ctx = ctx;
    this.constructors = constructorData;
  }
  
  public String toString() {
    String _xblockexpression = null;
    {
      boolean _or = false;
      boolean _equals = Objects.equal(this.constructors, null);
      if (_equals) {
        _or = true;
      } else {
        int _size = this.constructors.size();
        boolean _equals_1 = (_size == 0);
        _or = _equals_1;
      }
      if (_or) {
        return "";
      }
      StringConcatenation _builder = new StringConcatenation();
      {
        List<ConstructorData> _nullSafe = CollectionExtensions.<ConstructorData>nullSafe(this.constructors);
        for(final ConstructorData constructor : _nullSafe) {
          SrcConstructorWithParamsAssignment _srcConstructorWithParamsAssignment = new SrcConstructorWithParamsAssignment(this.ctx, constructor);
          _builder.append(_srcConstructorWithParamsAssignment, "");
          _builder.newLineIfNotEmpty();
          _builder.newLine();
        }
      }
      _xblockexpression = _builder.toString();
    }
    return _xblockexpression;
  }
}
