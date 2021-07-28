'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Photo extends Model {
    static associate(models) {
      // define association here
      this.belongsTo(models.Post, {
                foreignKey: 'post_id'
      });
      this.belongsTo(models.Comment, {
                foreignKey: 'comment_id'
      });
      //this.belongsTo(models.Inquiry, {
      //          foreignKey: 'inquiry_id'
      //});
      this.belongsTo(models.User, {
                foreignKey: 'user_id'
      });
    
    }
  };
  Photo.init({
    id: {
        primaryKey: true,
        autoIncrement: true,
        type: DataTypes.INTEGER,
        allowNull: false
    },
    post_id: {
        type: DataTypes.INTEGER,
        defaultValue: null,
        allowNull: true,
    },
    comment_id: {
        type: DataTypes.INTEGER,
        defaultValue: null,
        allowNull: true,
    },
    inquiry_id: {
        type: DataTypes.INTEGER,
        defaultValue: null,
        allowNull: true,
    },
    user_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
    original_file_name: {
        type: DataTypes.STRING(255),
        allowNull: false,
    },
    saved_file_name: {
        type: DataTypes.STRING(255),
        allowNull: false,
    },
    size: {
        type: DataTypes.BLOB,
        allowNull: false,
    },
    saved_path: {
        type: DataTypes.STRING(255),
        allowNull: false,
    },
    saved_date: {
        type: DataTypes.DATE,
        allowNull: false,
    },
    revised_date: {
        type: DataTypes.DATE,
        allowNull: false,
    },
    deleted_date: {
        type: DataTypes.DATE,
        allowNull: false
    },
    deleted_status: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
  },{

    sequelize,
    modelName: 'Photo',
    tableName: 'Photos'
  });
  return Photo;

};


