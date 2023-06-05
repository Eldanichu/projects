using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Reflection;
using godotcsharpgame.Database.Attribute;

public class AttributeOfValue<T, U> where T : PropertyAttribute {

  public Global.PROP_TYPE Type { set; get; }
  public Dictionary<string, object> GetProps(U props) {
    var dict = new Dictionary<string, object>();
    var propties = typeof(U).GetProperties(BindingFlags.Instance | BindingFlags.Public);

    foreach (var prop in propties) {
      var attr = prop.GetCustomAttribute<T>();
      if (attr == null) continue;
      if (attr.Type != Type) continue;
      var value = GetPropertyValue(props, attr.Name);
      dict.Add(attr.Name, value);
    }

    return dict;
  }

  private object GetPropertyValue<T>(T obj, string propertyName) {
    var propertyInfo = typeof(T).GetProperty(propertyName);
    var propertyExpression = Expression.Property(Expression.Constant(obj), propertyInfo);
    var valueExpression = Expression.Convert(propertyExpression, typeof(object));
    var getter = Expression.Lambda<Func<object>>(valueExpression).Compile();
    return getter();
  }
}
