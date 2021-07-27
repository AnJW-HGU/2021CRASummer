'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
    class Post extends Model {
        static associate(models) {
	    this.hasMany(models.Comment);
            this.hasMany(models.Photo);
            //this.hasOne(models.Inpuiry);              // check reported post in inpuiry
            this.belongsTo(models.Classification, {
                foreignKey: 'classification_id'
            });
            this.belongsTo(models.User, {
                foreignKey: 'user_id'
            });
	}
    };
    Post.init({
        id: {
            primaryKey: true,
            autoIncrement: true,
            type: DataTypes.SMALLINT,
            allowNull: false
        },
        classification_id: {
            type: DataTypes.SMALLINT,
            allowNull: false
        },
        user_id: {
            type: DataTypes.SMALLINT,
            allowNull: false,
        },
        title: {
            type: DataTypes.STRING(100),
            allowNull: false,
        },
        content: {
            type: DataTypes.TEXT,
            allowNull: false,
        },
        comments_count: {
            type: DataTypes.SMALLINT,
            allowNull: false,
            defaultValue: 0,
        },
        reports_count: {
            type: DataTypes.SMALLINT,
            allowNull: false,
            defaultValue: 0,
        },
        written_date: {
            type: DataTypes.DATE,
            allowNull: false,
        },
        revised_date: {
            type: DataTypes.DATE,
            allowNull: false,
        },
        deleted_date: {
            type: DataTypes.DATE,
            allowNull: false,
        },
        adopted_status: {
            type: DataTypes.TINYINT(1),
            allowNull: false
        },
        deleted_status: {
            type: DataTypes.TINYINT(1),
            allowNull: false
        },
    },{
	sequelize,
	modelName: 'Post',
        tableName: 'Posts'
    } );
    return Post;
};

