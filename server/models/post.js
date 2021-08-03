'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
    class Post extends Model {
        static associate(models) {
	        this.hasMany(models.Comment, {
                foreignKey: 'post_id'
            });
            this.hasMany(models.Photo, {
                foreignKey: 'post_id'
            });
			this.hasMany(models.Report, {
                foreignKey: 'post_id'
            });
            this.hasMany(models.Notification, {
                foreignKey: 'post_id'
            });
			this.hasMany(models.Inquiry, {
				foreignKey: 'post_id'
            });
			this.belongsTo(models.Classification, {
                foreignKey: 'classification_id',
            });
            this.belongsTo(models.User, {
                foreignKey: 'user_id',
            });
	    }
    };
    Post.init({
        id: {
            primaryKey: true,
            autoIncrement: true,
            type: DataTypes.INTEGER,
            allowNull: false
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
            type: DataTypes.INTEGER,
            allowNull: false,
            defaultValue: 0,
        },
        reports_count: {
            type: DataTypes.INTEGER,
            allowNull: false,
            defaultValue: 0,
        },
        adopted_status: {
            type: DataTypes.INTEGER,
            allowNull: false,
            defalutValue: 0
        },
        deleted_status: {
            type: DataTypes.INTEGER,
            allowNull: true,
            defalutValue: 0
        },
    },{
        sequelize,
        modelName: 'Post',
        tableName: 'Posts',
        createdAt: 'written_date',
        updatedAt: 'revised_date',
    } );
    return Post;
};
