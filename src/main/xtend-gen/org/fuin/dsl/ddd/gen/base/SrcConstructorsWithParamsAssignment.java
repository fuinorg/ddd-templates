package org.fuin.dsl.ddd.gen.base;

import com.google.common.base.Objects;
import java.util.ArrayList;
import java.util.List;
import org.eclipse.emf.common.util.EList;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractVO;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.InternalType;
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
   * Constructor with internal type.
   * 
   * @param ctx Context.
   * @param type Type.
   */
  public SrcConstructorsWithParamsAssignment(final CodeSnippetContext ctx, final InternalType type) {
    this.ctx = ctx;
    ArrayList<ConstructorData> _arrayList = new ArrayList<ConstructorData>();
    this.constructors = _arrayList;
    EList<Constructor> _constructors = type.getConstructors();
    List<Constructor> _nullSafe = CollectionExtensions.<Constructor>nullSafe(_constructors);
    for (final Constructor con : _nullSafe) {
      String _name = type.getName();
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
  public SrcConstructorsWithParamsAssignment(final CodeSnippetContext ctx, final String typeName, final AbstractVO vo) {
    this.ctx = ctx;
    ArrayList<ConstructorData> _arrayList = new ArrayList<ConstructorData>();
    this.constructors = _arrayList;
    ConstructorData _constructorData = new ConstructorData("/** Default constructor. */", "protected", typeName, null, null);
    this.constructors.add(_constructorData);
    boolean _or = false;
    EList<Variable> _variables = vo.getVariables();
    boolean _equals = Objects.equal(_variables, null);
    if (_equals) {
      _or = true;
    } else {
      EList<Variable> _variables_1 = vo.getVariables();
      int _size = _variables_1.size();
      boolean _equals_1 = (_size == 0);
      _or = _equals_1;
    }
    if (_or) {
      EList<Variable> _variables_2 = vo.getVariables();
      ConstructorData _constructorData_1 = new ConstructorData("/** Constructor with all data. */", "public", typeName, _variables_2, null);
      this.constructors.add(_constructorData_1);
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
    this.constructors = this.constructors;
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
